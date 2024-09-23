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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.MusicPaging;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.service.PlaylistMusicService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.SpotifyService;
import com.master.vibe.service.TagService;

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

	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException{
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		File copyFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + fileName);
		file.transferTo(copyFile);
		return fileName;
	}

	// 플레이리스트 생성 처리
	@PostMapping("/createPlaylist")
	public String createPlaylist(CreatePlaylistDTO dto, Model model) throws IllegalStateException, IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		// 이미지 선택 여부 확인
		String fileName;
		if (dto.getPlUrl() != null && !dto.getPlUrl().isEmpty() && !dto.getPlUrl().getOriginalFilename().equals("")) {
		fileName = fileUpload(dto.getPlUrl());
		dto.setPlImg("http://192.168.10.6:8080/playlistImg/" + fileName);
		} else {
			// 이미지 선택하지 않은 경우 기본 이미지 URL 설정
			dto.setPlImg(DEFAULT_IMAGE_URL);
		}

		// 현재 접속중인 user 정보로 플레이리스트 생성 처리
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

	// 사용자의 플레이리스트 상세 화면
	@GetMapping("/showPlaylistInfo")
	public String showPlaylistInfo(MusicPaging paging, Model model) {
		// 해당 플레이리스트의 음악 정보 가져오기
		List<String> musicCode = playlistMusicService.showMusicList(paging);
		
		// musicCode 리스트가 비어있지 않다면
		if (musicCode.size() != 0) {
			List<Music> musicInfo = spotifyService.getMusicInfoByMusicCode(musicCode); // 음악 정보 조회
			model.addAttribute("musicList", musicInfo); // 조회된 음악 정보 모델에 추가
		}
		
		// plCode로 해당 플레이리스트 정보 조회
		Playlist playlist = playlistService.selectPlaylistByPlCode(paging.getPlCode());
		model.addAttribute("playlist", playlistViewer.onePlaylistView(playlist)); // 조회된 플레이리스트 정보 모델에 추가
		
		return "playlist/showPlaylistInfo";
	}
	
	@ResponseBody
	@GetMapping("/limitPlaylistMusicList")
	public List<Music> limitPlaylistMusicList(MusicPaging paging, int plCode) {
		paging.setPlCode(plCode);
		List<String> musicCode = playlistMusicService.showMusicList(paging);
		
		return spotifyService.getMusicInfoByMusicCode(musicCode);
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

	// 플레이리스트 수정 페이지 요청
	@GetMapping("/updatePlaylist")
	public String updatePlaylist(String plCode, Model model) {
		// plCode로 플레이리스트 정보 조회하고 모델에 추가
		model.addAttribute("playlist", playlistService.selectPlaylistByPlCode(Integer.parseInt(plCode)));
		return "playlist/updatePlaylist";
	}

	// 플레이리스트 수정 페이지 정보 업데이트
	@PostMapping("/updatePlaylist")
	public String updatePlaylist(UpdatePlaylistDTO dto) throws IllegalStateException, IOException {

		// 기존 플레이리스트 정보 조회
		Playlist playlist = playlistService.selectPlaylistByPlCode(dto.getPlCode());

		// 새 이미지 파일 업로드 처리
		String newFileName = null;
		if (dto.getPlImgFile() != null && !dto.getPlImgFile().isEmpty()) {

			// 기존 이미지 파일 삭제
			String existImg = new File(playlist.getPlImg()).getName();
			if (!playlist.getPlImg().equals("http://192.168.10.6:8080/playlistImg/defaultCD.png")) {
				// 기본 이미지가 아닌 경우에만 삭제
				if (existImg != null && !existImg.isEmpty()) {
					File file = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + existImg); // 파일을 저장할 실제 경로
					if (file.exists()) file.delete(); // 기존 파일 삭제
				}
			}
			
			// 새 이미지 파일 생성 및 저장
			UUID uuid = UUID.randomUUID();
			newFileName = uuid.toString() + "_" + dto.getPlImgFile().getOriginalFilename();
			File newFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + newFileName);

			dto.getPlImgFile().transferTo(newFile); // 새 파일로 저장
			newFileName = "http://192.168.10.6:8080/playlistImg/" + newFileName; // 새 이미지 URL 생성

		} else if (dto.getDefaultImg() != null && !dto.getDefaultImg().isEmpty()) {
			// 사용자가 버튼을 클릭하여 기본 이미지로 변경한 경우
			newFileName = dto.getDefaultImg(); // 기본 이미지 URL 사용(defaultCD.img)
		} else {
			// 이미지 파일이 변경되지 않은 경우, 기존 이미지 유지
			newFileName = playlist.getPlImg();
		}

		// Playlist 객체를 사용하여 플레이리스트 업데이트
		playlist.setPlTitle(dto.getPlTitle());
		playlist.setPlImg(newFileName); // 새 이미지 파일 이름으로 업데이트
		playlist.setPlPublicYn(dto.getPlPublicYn()); // 공개/비공개 설정 업데이트
		
		// 플레이리스트 서비스 호출하여 업데이트된 정보 저장
		playlistService.updatePlaylist(playlist);

		// 수정 후 저장 시 변경된 정보로 화면 리다이렉트(해당 플레이리스트 화면)
		return "redirect:/showPlaylistInfo?plCode=" + dto.getPlCode();
	}

	// 랭킹 : 좋아요순
	@GetMapping("/likeranking")
	public String likeranking(SearchDTO dto, Model model) {
		List<Playlist> playlist = playlistService.likerankingPlaylist(dto);
		model.addAttribute("searchTag", playlistViewer.playlistView(playlist));
		return "ranking/likeranking";
	}
	
	@ResponseBody
	@GetMapping("/limitLikeRankList")
	public List<PlaylistDTO> limitLikeRankList(SearchDTO dto) {
		List<Playlist> playlist = playlistService.likerankingPlaylist(dto);
		return playlistViewer.playlistView(playlist);
	}
	
	// 한달 동안의 플레이리스트 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnMonth")
	public String playListRankingOnMonth(Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnMonth();
		model.addAttribute("playListRankingOnMonth", playlist);
		return "ranking/playListRankingOnMonth";
	}

	// 연령별 좋아요 랭킹 조회	
	@GetMapping("/playListRankingOnAgeGroup")
	public String playListRankingOnAgeGroup(SearchDTO dto, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnAgeGroup(dto);
		model.addAttribute("searchTag", playlistViewer.playlistView(playlist));
		model.addAttribute("ageGroup", dto.getAgeGroup());
		return "ranking/playListRankingOnAgeGroup";
	}
	
	@ResponseBody
	@GetMapping("/limitAgeRankList")
	public List<PlaylistDTO> limitAgeRankList(SearchDTO dto) {
		List<Playlist> playlist = playlistService.playListRankingOnAgeGroup(dto);
		return playlistViewer.playlistView(playlist);
	}

	// 성별 별 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnGender")
	public String playListRankingOnGender(SearchDTO dto, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnGender(dto);
		
		model.addAttribute("searchTag", playlistViewer.playlistView(playlist));
		model.addAttribute("userGender", dto.getUserGender());
		return "ranking/playListRankingOnGender";
	}
	
	@ResponseBody
	@GetMapping("/limitGenderRankList")
	public List<PlaylistDTO> limitGenderRankList(SearchDTO dto) {
		List<Playlist> playlist = playlistService.playListRankingOnGender(dto);
		return playlistViewer.playlistView(playlist);
	}
}