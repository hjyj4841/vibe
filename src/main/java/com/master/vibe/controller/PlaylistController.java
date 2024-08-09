package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.DeletePlaylistDTO;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.TagService;

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
    public RedirectView createPlaylist(CreatePlaylistDTO dto) {
        int playlistId = playlistService.createPlaylist(dto);
        // 생성된 플레이리스트 ID를 태그 입력 페이지로 전달
        return new RedirectView("/addTags?playlistId=" + playlistId);
    }

    // 플레이리스트 삭제
    @GetMapping("/deletePlaylist")
    public String deletePlaylist() {
    	return "test/playlist/deletePlaylist";
    }
    
    @PostMapping("/deletePlaylist")
    public String deletePlaylist(DeletePlaylistDTO dto) {
        playlistService.deletePlaylist(dto);
        return "test/test";
    }
    
    // 플레이리스트 수정
    @GetMapping("/updatePlaylist")
    public String updatePlaylist() {
        return "test/playlist/updatePlaylist";
    }

    @PostMapping("/updatePlaylist")
    public String updatePlaylist(UpdatePlaylistDTO dto) {
        playlistService.updatePlaylistTitle(dto);
        return "test/test";
    }

}