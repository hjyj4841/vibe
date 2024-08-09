package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.service.PlaylistService;


// 현재 PlaylistController.java에서 @PostMapping("/addPlaylist") 메소드가 List<String> 타입의 selectedMusic을 받고 있습니다.
// 그러나 선택된 음악 정보는 문자열이 아니라 복잡한 객체 구조임

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService playlistService;
	
	// 플레이리스트 전체 조회 페이지
    @GetMapping("/searchHome")
	public String searchAllPlaylist(Model model) {
		model.addAttribute("allPlaylist", playlistService.allPlaylist());
		return "test/search/searchHome";
	}
    
    // 플레이리스트 생성
    @GetMapping("/createPlaylist")
    public String createPlaylist() {
    	return "test/playlist/createPlaylist";
    }
    @PostMapping("/createPlaylist")
    public String createPlaylist(CreatePlaylistDTO dto, Model model) {
        playlistService.createPlaylist(dto);
        
        // createPlaylist.jsp에서 사용자가 플레이리스트 생성 시 기본으로 plImg /createplaylistimg/default.png를 불러옴
        model.addAttribute("plImg", dto.getPlImg());
        
        // createPlaylist.jsp에서 사용자가 입력한 plTitle 불러옴
        model.addAttribute("plTitle", dto.getPlTitle());
        
        return "test/playlist/createPlaylistInfo"; // 생성된 플레이리스트 정보 페이지로 이동
        
        //return "test/playlist/createOKPlaylist"; // 플레이리스트 생성 완료 페이지로 이동
    }
    

	
    /*
    // 플레이리스트 생성 처리
    @PostMapping("/createPlaylist")
    public String createPlaylist(CreatePlaylistDTO dto, Model model) {
        playlistService.createPlaylist(dto);
        
        // DTO에서 제목을 추출하여 모델에 추가
        model.addAttribute("plTitle", dto.getPlTitle());
        
        // 생성된 플레이리스트 정보 페이지로 이동
        return "test/playlist/createPlaylistInfo";
    }
    */
    
}