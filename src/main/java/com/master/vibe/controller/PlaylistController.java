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
import org.springframework.web.multipart.MultipartFile;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.service.PlaylistMusicService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.SpotifyService;
import com.master.vibe.service.TagService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService playlistService;
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
	@Autowired
	private TagService tagService;
	
	@Autowired
	private SpotifyService spotifyService;
	
	// 플레이리스트 이미지 업로드 관련 2024.08.16/현호
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

    @PostMapping("/createPlaylist")
    public String createPlaylist(CreatePlaylistDTO dto, HttpServletRequest request) throws IllegalStateException, IOException {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
        
		System.out.println(dto.getPlUrl());
		String fileName = fileUpload(dto.getPlUrl());

        dto.setUserEmail(user.getUserEmail());
        
//		dto.setPlImg("http://localhost:8081/playlistImg/" + fileName);
		dto.setPlImg("http://192.168.10.6:8080/playlistImg//" + fileName);
		playlistService.createPlaylist(dto);
		
        // 태그 입력값 받기
        List<String> tagNames = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            String tag = request.getParameter("tag" + i);
            if (tag != null && !tag.trim().isEmpty()) {
                tagNames.add(tag.trim());
            }
        }
        
        // 태그 서비스 호출
        tagService.addTagsByName(tagNames);

        // 플레이리스트와 태그 연동
        int plCode = dto.getPlCode(); // 생성된 플레이리스트 코드 가져오기
        tagService.addPlaylistTags(plCode, tagNames);
        
        return "redirect:/myPlaylist";
    }
    
    @GetMapping("/showPlaylistInfo")
    public String showPlaylistInfo(int plCode, Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
    	
    	List<String> musicCode = playlistMusicService.showMusicList(plCode);
        Playlist playlist = playlistService.selectPlaylistByPlCode(plCode);
//      List<String> tagList = playlistService.getTagsByPlaylistCode(plCode);
        
        if(musicCode.size() != 0) {
    		List<Music> musicInfo = spotifyService.getMusicINfoByMusicCode(musicCode);
    		model.addAttribute("musicList", musicInfo);
    	}
        
        model.addAttribute("user", user);
        model.addAttribute("playlist", playlist);
//      model.addAttribute("tagList", tagList);
        
        return "playlist/showPlaylistInfo";
    }
    
    // 회원본인의 플레이리스트 조회
    @GetMapping("/myPlaylist")
    public String myPlaylist(Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
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
    	
    	model.addAttribute("playlist", 
    			playlistService.selectPlaylistByPlCode(Integer.parseInt(plCode)));
    	
        return "playlist/updatePlaylist";
    }
    
    @PostMapping("/updatePlaylist")
    public String updatePlaylist(UpdatePlaylistDTO dto) throws IllegalStateException, IOException {

    	// 기존 플레이리스트 정보 조회
    	Playlist playlist = playlistService.selectPlaylistByPlCode(dto.getPlCode());

    	// 기존 이미지 파일 삭제
    	String existImg = playlist.getPlImg();
    	if(existImg != null && !existImg.isEmpty()) {
    		System.out.println("존재하는 파일 : " + existImg);
    		File file = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + existImg); // 실제 경로로 변경
    		if(file.exists()) {
    			file.delete();
    		}
    	}
    		
    	/*
    	// 기존 이미지 파일 삭제
    	if(dto.getPlImgFile() != null && !dto.getPlImgFile().isEmpty()) {
    	
	    	String existImgPath = playlist.getPlImg();
	    	if(existImgPath != null && !existImgPath.isEmpty()) {
	    		File file = new File("http://192.168.10.6:8080/playlistImg//" + existImgPath);
	    		
	    		if(file.exists()) {
	    			file.delete();
	    		}
	    	}
	    	*/ 	
    	
    	// 새 이미지 파일 업로드
    	String newFileName = null;
    	if(dto.getPlImgFile() != null && !dto.getPlImgFile().isEmpty()) {
    		UUID uuid = UUID.randomUUID();
    		newFileName = uuid.toString() + "_" + dto.getPlImgFile().getOriginalFilename();
    		System.out.println("새로 들어온 파일 : " + newFileName);
    		File newFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + newFileName); // 실제 경로로 변경
    		
    		System.out.println(newFile.getPath());
    		
    		dto.getPlImgFile().transferTo(newFile);
    	} else {
    		// 이미지 파일 변경하지 않았으면 기존 이미지 유지
    		newFileName = playlist.getPlImg();
    	}
    	
    	// Playlist 객체를 사용하여 플레이리스트 업데이트
    	playlist.setPlTitle(dto.getPlTitle());
    	playlist.setPlImg(newFileName); // 새 이미지 파일 이름으로 설정
    	
    	/*
    	// DTO를 사용하여 플레이리스트 업데이트
    	Playlist updatedPlaylist = new Playlist();
    	updatedPlaylist.setPlCode(dto.getPlCode());
    	updatedPlaylist.setPlTitle(dto.getPlTitle());
    	updatedPlaylist.setPlImg(newFileName); // 이미지 파일 이름을 경로로 설정
    	*/
    	
    	playlistService.updatePlaylist(playlist); // 수정된 서비스 메서드 호출
        
        // 플레이리스트 수정 후 저장 시 변경한 정보로 저장 후 이전 화면으로 이동(선택한 플레이리스트 화면)
//        return "redirect:/showPlaylistInfo?plCode=" + playlist.getPlCode();
        return "redirect:/showPlaylistInfo?plCode=" + dto.getPlCode();
    
    }
    
    
    // 랭킹 관련
    @GetMapping("/rankingHome")
    public String rankingHome() {
    	return "ranking/rankingHome";
    }
    
    // 랭킹 : 좋아요순
    @GetMapping("/likeranking")
    public String likeranking(Model model) {
    	model.addAttribute("likeranking", playlistService.likerankingPlaylist());
		return "ranking/likeranking";
    }

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
	
}