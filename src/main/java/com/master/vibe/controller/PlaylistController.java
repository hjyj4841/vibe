package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistService;

// 현재 PlaylistController.java에서 @PostMapping("/addPlaylist") 메소드가 List<String> 타입의 selectedMusic을 받고 있습니다.
// 그러나 선택된 음악 정보는 문자열이 아니라 복잡한 객체 구조임

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService playlistService;
	
    // 플레이리스트 추가 폼 불러오기
    @GetMapping("/playlist")
    public String showAddPlaylistForm(Model model, @RequestParam(value = "selectedMusic", required = false) List<String> selectedMusic) {
        model.addAttribute("selectedMusic", selectedMusic);
        return "playlist";
    }
	
    // 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직을 구현
    @PostMapping("/addPlaylist")
    public String addPlaylist(@RequestParam("selectedMusic") List<String> selectedMusic, Model model) {
        // selectedMusic 리스트를 Playlist 객체로 변환하는 로직 필요
        // 이 예제에서는 단순히 추가된 음악 목록을 출력함
    	System.out.println(selectedMusic);
        model.addAttribute("selectedMusic", selectedMusic);
        return "playlist"; // playlist.jsp로 리다이렉트
    }
    
    // 플레이리스트 추가
    @PostMapping("/playlist")
    public String addPlaylist(Playlist playlist) {
    	playlistService.addPlaylist(playlist);
    	return "redirect:/"; // 플레이리스트 추가 후 메인 페이지로 리다이렉트
    }

    
    // ================================== 수정 요망 =========================================
    @PostMapping("/createPlaylist")
    public String createPlaylist(@RequestParam("pl_title") String pt, @RequestParam("user_email") String ue) {
        Playlist playlist = new Playlist();
        playlist.setPlTitle(pt);
        
        User u = new User();
        
        u.setUserEmail(ue);
        
        playlist.setUser(u);

        playlistService.createPlaylist(playlist);

        return "test/test";
    }

    @GetMapping("/viewPlaylist")
	public String index(Model model) {
		model.addAttribute("allPlaylist", playlistService.allPlaylist());
		return "/test/viewPlaylistTest";
	}
	
    
    
//	어떤 기능 ???
//
//	public PlaylistController(SpotifyService spotifyService) {
//		this.spotifyService = spotifyService;
//	}
//
//	
//	@GetMapping("/playlists")
//	public String searchPlaylists(@RequestParam String query) {
//		 return spotifyService.searchPlaylists(query);
//	}
	

	
	/*
	// 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직을 구현
	@PostMapping("/addPlaylist")
	public String addPlaylist(@RequestParam("selectedMusic") List<String> selectedMusic, Model model) {
		System.out.println(selectedMusic);
		
		playlistService.addPlaylist(selectedMusic);
		model.addAttribute("selectedMusic", selectedMusic);
	    return "playlist"; // 작업 완료 후
	}
	*/
	
	/*
	@PostMapping("/addPlaylist")
	public String addPlaylist(@RequestParam("selectedMusic") String selectedMusicJson, Model model) {
		// ObjectMapper를 사용하여 JSON 문자열을 List로 변환
		ObjectMapper objectMapper = new ObjectMapper();
        List<List<String>> selectedMusic = null;
        try {
            selectedMusic = objectMapper.readValue(selectedMusicJson, new TypeReference<List<List<String>>>() {});
        } catch (Exception e) {
            e.printStackTrace();
        }
		
        // 선택된 음악 정보를 모델에 추가
        model.addAttribute("selectedMusic", selectedMusic);
        return "playlist"; // 플레이리스트 추가 후 'playlist.jsp'로 리턴
    }
    */
	
	/*
    // 플레이리스트 추가 폼 불러오기
	@GetMapping("/playlist")
	public String addPlaylist(Model model) {
		return "playlist";
	}
	*/
	
}














