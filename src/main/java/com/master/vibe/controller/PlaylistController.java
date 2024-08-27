package com.master.vibe.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Paging;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.service.PlaylistMusicService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;
import com.master.vibe.service.SpotifyService;
import com.master.vibe.service.TagService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PlaylistController {

	// 기본 이미지 URL 상수 정의
	private static final String DEFAULT_IMAGE_URL = "http://192.168.10.6:8080/playlistImg/defaultCD.png";

	@Autowired
	private PlaylistService playlistService;

	@Autowired
	private PlaylistMusicService playlistMusicService;

	@Autowired
	private TagService tagService;

	@Autowired
	private SpotifyService spotifyService;

	@Autowired
	private PlaylistViewer playlistViewer;

	@Autowired
	private PlaylistTagService playlistTagService;


	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		System.out.println(fileName);
		File copyFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + fileName);

		System.out.println(copyFile.getPath());

		file.transferTo(copyFile);
		return fileName;
	}

	// 플레이리스트 전체 조회 페이지
	@ResponseBody
	@GetMapping("/searchHome")
	public String searchAllPlaylist(Model model) {
		SearchDTO dto = new SearchDTO();
		model.addAttribute("allPlaylist", playlistService.allPlaylist(dto));
		return "test/search/searchHome";
	}

	// 플레이리스트 생성
	@GetMapping("/createPlaylist")
	public String createPlaylist(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		model.addAttribute("user", user);

		return "playlist/createPlaylist";
	}

	// 플레이리스트 생성 처리
	@PostMapping("/createPlaylist")
	public String createPlaylist(CreatePlaylistDTO dto, HttpServletRequest request)
			throws IllegalStateException, IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();


//		String fileName = fileUpload(dto.getPlUrl());

		// 이미지 선택 여부 확인
		String fileName;
		if (dto.getPlUrl() != null && !dto.getPlUrl().isEmpty() && !dto.getPlUrl().getOriginalFilename().equals("")) {
			fileName = fileUpload(dto.getPlUrl());
			dto.setPlImg("http://192.168.10.6:8080/playlistImg/" + fileName);
		} else {
			// 이미지 선택하지 않은 경우 기본 이미지 URL 설정
			dto.setPlImg(DEFAULT_IMAGE_URL);
		}

		dto.setUserEmail(user.getUserEmail());
		playlistService.createPlaylist(dto);


		// 태그 입력값 받기
		// String tags = request.getParameter("tags"); // 태그가 콤마로 구분된 문자열 형태로 전달됨
		List<String> newTags = new ArrayList<>();
		for (String tag : dto.getTags()) {
			newTags.add(tag.split(":")[1].replace("}", "").replace("\"", "").replace("]", ""));
		}
		dto.setTags(newTags);

		// 태그 서비스 호출
		List<Integer> tagCodes = tagService.addTagsByName(dto.getTags());

		// 플레이리스트와 태그 연동
		tagService.addPlaylistTags(Integer.parseInt(dto.getPlCode()), tagCodes);
		return "redirect:/myPlaylist";
	}

	@GetMapping("/showPlaylistInfo")
	public String showPlaylistInfo(int plCode, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = null;
		if (!authentication.getName().equals("anonymousUser")) {
			user = (User) authentication.getPrincipal();
			model.addAttribute("user", user);
		}
		List<String> musicCode = playlistMusicService.showMusicList(plCode);
		Playlist playlist = playlistService.selectPlaylistByPlCode(plCode);

		List<PlaylistTag> tags = playlistTagService.searchTagPlaylist(plCode);

		if (musicCode.size() != 0) {
			List<Music> musicInfo = spotifyService.getMusicINfoByMusicCode(musicCode);
			model.addAttribute("musicList", musicInfo);
		}
		model.addAttribute("user", user);
		model.addAttribute("playlist", playlist);

		// 태그 목록을 모델에 추가
		model.addAttribute("tags", tags);

		return "playlist/showPlaylistInfo";
	}

	// 회원본인의 플레이리스트 조회
	@GetMapping("/myPlaylist")
	public String myPlaylist(SearchDTO dto, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		dto.setUserEmail(user.getUserEmail());
		
		List<Playlist> playlist = playlistService.myPlaylist(dto);
		
		model.addAttribute("searchTag", playlistViewer.playlistView(playlist));
		return "playlist/myPlaylist";
	}
	
  	@ResponseBody
  	@PostMapping("/limitMyList")
  	public List<PlaylistDTO> limitMyList(SearchDTO dto) {
  		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		dto.setUserEmail(user.getUserEmail());
		
  		List<Playlist> playlist = playlistService.myPlaylist(dto);
  		
  		return playlistViewer.playlistView(playlist);
  	}

	// 플레이리스트 삭제
	@GetMapping("/deletePlaylist")
	public String deletePlaylist(String plCode) {
		playlistService.deletePlaylist(Integer.parseInt(plCode));
		return "redirect:/myPlaylist";
	}

	// 플레이리스트 수정 -- 현재는 이름만 수정 가능
	@GetMapping("/updatePlaylist")
	public String updatePlaylist(String plCode, Model model) {

		model.addAttribute("playlist", playlistService.selectPlaylistByPlCode(Integer.parseInt(plCode)));

		return "playlist/updatePlaylist";
	}

	@PostMapping("/updatePlaylist")
	public String updatePlaylist(UpdatePlaylistDTO dto) throws IllegalStateException, IOException {

		// 기존 플레이리스트 정보 조회
		Playlist playlist = playlistService.selectPlaylistByPlCode(dto.getPlCode());

		// 새 이미지 파일 업로드
		String newFileName = null;
		if (dto.getPlImgFile() != null && !dto.getPlImgFile().isEmpty()) {

			// 기존 이미지 파일 삭제
			String existImg = playlist.getPlImg();
			if (existImg != null && !existImg.isEmpty()) {
				System.out.println("존재하는 파일 : " + existImg);
				File file = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + existImg); // 파일을 저장할 실제 경로로 설정
				if (file.exists()) {
					file.delete();
				}
			}

			UUID uuid = UUID.randomUUID();
			newFileName = uuid.toString() + "_" + dto.getPlImgFile().getOriginalFilename();
			System.out.println("새로 들어온 파일 : " + newFileName);
			File newFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + newFileName);

			System.out.println(newFile.getPath());

			dto.getPlImgFile().transferTo(newFile);
			newFileName = "http://192.168.10.6:8080/playlistImg/" + newFileName;

			// defaultImg가 null이 아니다 -> 기본 이미지 URL이(defaultCD.img) 전달되었다. defaultImg가 비어있지
			// 않다 -> 기본 이미지 URL이 빈 문자열이 아니다.
			// 이 조건문이 참인 경우, 기본 이미지 URL이 폼 데이터에 포함되었음을 의미, 이를 새 이미지로 설정
		} else if (dto.getDefaultImg() != null && !dto.getDefaultImg().isEmpty()) {
			// 기본 이미지 URL이 폼에 포함된 경우로
			// 사용자가 "기본 이미지로" 버튼을 클릭하여 기본 이미지로 변경한 경우, 기존의 이미지 파일을 변경하지 않고 이 기본 이미지 URL을 새
			// 이미지로 사용 -> 즉, defaultCD.img로 설정하겠다.
			newFileName = dto.getDefaultImg();
		} else {
			// 이미지 파일 변경하지 않았으면 기존 이미지 유지
			// 사용자가 이미지 파일을 업로드하지 않았고, 기본 이미지로 리셋하지 않은 경우에는 기존 이미지 URL을 그대로 유지
			newFileName = playlist.getPlImg();
		}

		// Playlist 객체를 사용하여 플레이리스트 업데이트
		playlist.setPlTitle(dto.getPlTitle());
		playlist.setPlImg(newFileName); // 새 이미지 파일 이름으로 설정

		/*
		 * // DTO를 사용하여 플레이리스트 업데이트 Playlist updatedPlaylist = new Playlist();
		 * updatedPlaylist.setPlCode(dto.getPlCode());
		 * updatedPlaylist.setPlTitle(dto.getPlTitle());
		 * updatedPlaylist.setPlImg(newFileName); // 이미지 파일 이름을 경로로 설정
		 */

		playlistService.updatePlaylist(playlist); // 수정된 서비스 메서드 호출

		// 플레이리스트 수정 후 저장 시 변경한 정보로 저장 후 이전 화면으로 이동(선택한 플레이리스트 화면)
//      return "redirect:/showPlaylistInfo?plCode=" + playlist.getPlCode();
		return "redirect:/showPlaylistInfo?plCode=" + dto.getPlCode();

	}

	// 랭킹 관련 - 수정중
	@GetMapping("/rankingHome")
	public String rankingHome(String select, Model model) {
		return "ranking/rankingHome";
	}

	// 랭킹 : 좋아요순
	@GetMapping("/likeranking")
	public String likeranking(Model model) {
		model.addAttribute("likeranking", playlistService.likerankingPlaylist());
		return "ranking/likeranking";
	}

	// mypage에서 직접 조회 처리
	// 플레이리스트 랜덤 조회
	// @GetMapping("/randomPlaylist")
	// public String randomPlaylist(Model model) {
	// List<Playlist> randomPlaylist = playlistService.randomPlaylist();
	// System.out.println(randomPlaylist);
	// model.addAttribute("randomPlaylist", randomPlaylist);
	// return "playlist/randomPlaylist";
	// }
	
	// 태그 검색 랭킹 조회
	@GetMapping("/searchTag")
	public String searchTag() {
		return "ranking/searchTag";
	}

	@GetMapping("/searchTagRanking")
	public String searchTagRanking(String tagName, Model model) {
		List<Playlist> playlist = playlistService.searchTagRanking(tagName);
		model.addAttribute("searchTagRanking", playlist);
		return "ranking/searchTagRanking";
	}

	// 한달 동안의 플레이리스트 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnMonth")
	public String playListRankingOnMonth(Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnMonth();
		model.addAttribute("playListRankingOnMonth", playlist);
		return "ranking/playListRankingOnMonth";
	}

	// 연령별 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnAgeGroupSelect")
	public String playListRankingOnAgeGroupSelect() {
		return "ranking/playListRankingOnAgeGroupSelect";
	}

	@PostMapping("/playListRankingOnAgeGroup")
	public String playListRankingOnAgeGroup(String ageGroup, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnAgeGroup(ageGroup);
		model.addAttribute("playListRankingOnAgeGroup", playlist);
		model.addAttribute("ageGroup", ageGroup);
		return "ranking/playListRankingOnAgeGroup";
	}

	// 성별 별 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnGenderSelect")
	public String playListRankingOnGenderSelect() {
		return "ranking/playListRankingOnGenderSelect";
	}

	@PostMapping("/playListRankingOnGender")
	public String playListRankingOnGender(String userGender, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnGender(userGender);
		model.addAttribute("playListRankingOnGender", playlist);
		model.addAttribute("userGender", userGender);
		return "ranking/playListRankingOnGender";
	}
	
	/*
	 * @PostMapping("/updatePlaylist") public String updatePlaylist(@ModelAttribute
	 * PlaylistDTO playlistDTO) { MultipartFile file = playlistDTO.getPlImg(); if
	 * (file != null && !file.isEmpty()) { // 파일 처리 로직 (예: 파일 저장) String fileName =
	 * file.getOriginalFilename(); // 파일 저장 위치 및 로직을 설정하세요. // 예:
	 * file.transferTo(new File("/path/to/save/" + fileName)); // 파일 저장 후, 경로를 DTO에
	 * 추가할 수 있습니다. // playlistDTO.setPlImgPath("/path/to/save/" + fileName); } //
	 * DTO를 사용하여 업데이트 로직 처리 playlistService.updatePlaylist(playlistDTO); return
	 * "redirect:/somePage"; }
	 */

	/*
	 * // 플레이리스트 생성 처리
	 * 
	 * @PostMapping("/createPlaylist") public String
	 * createPlaylist(CreatePlaylistDTO dto, Model model) {
	 * playlistService.createPlaylist(dto);
	 * 
	 * // DTO에서 제목을 추출하여 모델에 추가 model.addAttribute("plTitle", dto.getPlTitle());
	 * 
	 * // 생성된 플레이리스트 정보 페이지로 이동 return "test/playlist/createPlaylistInfo"; }
	 */
}