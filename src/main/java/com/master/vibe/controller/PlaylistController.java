package com.master.vibe.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.service.PlaylistService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService playlistService;
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadPath;

	// 플레이리스트 전체 조회 페이지
	@GetMapping("/searchHome")
	public String searchAllPlaylist(Model model) {
		SearchDTO dto = new SearchDTO();
		model.addAttribute("allPlaylist", playlistService.allPlaylist(dto));
		return "test/search/searchHome";
	}

	// 플레이리스트 이미지 업로드 관련 // 서버 연결 관련 차후 보완 필요! 2024.08.16/현호

//	@Value("${file.upload-dir}")
//	private String uploadDir;

	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		System.out.println(fileName);
//	    File copyFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + fileName);
		File copyFile = new File(uploadPath + File.separator + "playlistImg" + File.separator + fileName);
		
		System.out.println(copyFile.getPath());

		file.transferTo(copyFile);
		return fileName;
	}

	// 플레이리스트 생성
	@GetMapping("/createPlaylist")
	public String createPlaylist() {
		return "playlist/createPlaylist";
	}

	@PostMapping("/createPlaylist")
	public String createPlaylist(CreatePlaylistDTO dto, HttpServletRequest request)
			throws IllegalStateException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		System.out.println(dto.getPlUrl());
		String fileName = fileUpload(dto.getPlUrl());
		dto.setUserEmail(user.getUserEmail());
		dto.setPlImg("http://localhost:8081/playlistImg/" + fileName);
		// createPlaylist.jsp에서 사용자가 플레이리스트 생성 시 기본으로 plImg
		// /createplaylistimg/default.png를 불러옴 --> DB Default값으로 자동추가 되도록 수정 예정

		playlistService.createPlaylist(dto);

		return "redirect:/myPlaylist"; // 내가 만든 플레이리스트 조회
		// int playlistId = playlistService.createPlaylist(dto); -> 생성된 플레이리스트 ID를 태그 입력
		// 페이지로 전달
		// return new RedirectView("/addTags?playlistId=" + playlistId); -> 플레이리스트 태그 추가
		// 위함 -> 1) 상세 화면에서 수정가능 하도록 하는 방안 2) 생성시 태그 추가하는 기능은 보류
		// return "test/playlist/createPlaylistInfo"; // 생성된 플레이리스트 정보 페이지로 이동
		// return "test/playlist/createOKPlaylist"; // 플레이리스트 생성 완료 페이지로 이동

	}

	// 회원본인의 플레이리스트 조회
	@GetMapping("/myPlaylist")
	public String myPlaylist(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		model.addAttribute("playlist", playlistService.myPlaylist(user.getUserEmail()));

		return "playlist/myPlaylist";
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

		model.addAttribute("playlist", playlistService.selectPlaylistForPlCode(Integer.parseInt(plCode)));

		return "playlist/updatePlaylist";
	}

	@PostMapping("/updatePlaylist")
	public String updatePlaylist(Playlist playlist) {
		playlistService.updatePlaylistTitle(playlist);
		return "redirect:/myPlaylist";
	}

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

	// 플레이리스트 랜덤 조회
	@GetMapping("/randomPlaylist")
	public String randomPlaylist(Model model) {
		List<Playlist> randomPlaylist = playlistService.randomPlaylist();
		System.out.println(randomPlaylist);
		model.addAttribute("randomPlaylist", randomPlaylist);
		return "playlist/randomPlaylist";
	}

	// 태그 검색 랭킹 조회
	@GetMapping("/searchTag")
	public String searchTag() {
		return "playlist/searchTag";
	}

	@GetMapping("/searchTagRanking")
	public String searchTagRanking(String tagName, Model model) {
		List<Playlist> playlist = playlistService.searchTagRanking(tagName);
		model.addAttribute("searchTagRanking", playlist);
		return "playlist/searchTagRanking";
	}

	// 한달 동안의 플레이리스트 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnMonth")
	public String playListRankingOnMonth(Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnMonth();
		model.addAttribute("playListRankingOnMonth", playlist);
		return "playlist/playListRankingOnMonth";
	}

	// 연령별 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnAgeGroupSelect")
	public String playListRankingOnAgeGroupSelect() {
		return "playlist/playListRankingOnAgeGroupSelect";
	}

	@PostMapping("/playListRankingOnAgeGroup")
	public String playListRankingOnAgeGroup(String ageGroup, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnAgeGroup(ageGroup);
		model.addAttribute("playListRankingOnAgeGroup", playlist);
		model.addAttribute("ageGroup", ageGroup);
		return "playlist/playListRankingOnAgeGroup";
	}

}