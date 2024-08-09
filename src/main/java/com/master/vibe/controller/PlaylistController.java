package com.master.vibe.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
    public String createPlaylist(String plTitle, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        
    	playlistService.createPlaylist(new CreatePlaylistDTO(plTitle, user.getUserEmail()));
        return "test/test";
    }
    
    // 회원본인의 플레이리스트 조회
    @GetMapping("myPlaylist")
    public String myPlaylist(HttpServletRequest request, Model model) {
    	HttpSession session = request.getSession();
    	User user = (User)session.getAttribute("user");
    	
    	model.addAttribute("playlist", playlistService.myPlaylist(user.getUserEmail()));
    	
    	return "playlist/myPlaylist";
    }
	
    // 플레이리스트 좋아요 순 조회
//	@GetMapping("/playlists")
//	public String searchPlaylists(@RequestParam String query) {
//		 return spotifyService.searchPlaylists(query);
//	}
	
//	// 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직을 구현
//	@PostMapping("/addPlaylist")
//	public String addPlaylist(@RequestParam("selectedMusic") List<String> selectedMusic, Model model) {
//		System.out.println(selectedMusic);
//		
//		playlistService.addPlaylist(selectedMusic);
//		model.addAttribute("selectedMusic", selectedMusic);
//	    return "playlist"; // 작업 완료 후
//	}
//  // 플레이리스트 추가 폼 불러오기
//	@GetMapping("/playlist")
//	public String addPlaylist(Model model) {
//		return "playlist";
//	}
//	// 플레이리스트 추가
//	@PostMapping("/playlist")
//	public String addPlaylist(Playlist playlist) {
//		playlistService.addPlaylist(playlist);
//		return "redirect:/"; // 플레이리스트 추가 후 메인 페이지로 리다이렉트
//	}
}