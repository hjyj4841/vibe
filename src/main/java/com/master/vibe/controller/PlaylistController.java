package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.User;
import com.master.vibe.model.dto.DeletePlaylistDTO;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.TagService;

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

// 수정시 참고 예정
    // public String createPlaylist(CreatePlaylistDTO dto) {
    //     playlistService.createPlaylist(dto);
    //     return "redirect:/searchHome"; // test/test -> redirect:/searchHome // 내가 만든 플레이리스트 조회

    // 수정시 참고 예정
    //  public RedirectView createPlaylist(CreatePlaylistDTO dto) {
    //     int playlistId = playlistService.createPlaylist(dto);
    //     // 생성된 플레이리스트 ID를 태그 입력 페이지로 전달
    //     return new RedirectView("/addTags?playlistId=" + playlistId);
    // }

    // 수정시 참고 예정
    //  public String createPlaylist(CreatePlaylistDTO dto, Model model) {
    //     playlistService.createPlaylist(dto);
        
    //     // createPlaylist.jsp에서 사용자가 플레이리스트 생성 시 기본으로 plImg /createplaylistimg/default.png를 불러옴
    //     model.addAttribute("plImg", dto.getPlImg());
        
    //     // createPlaylist.jsp에서 사용자가 입력한 plTitle 불러옴
    //     model.addAttribute("plTitle", dto.getPlTitle());
        
    //     return "test/playlist/createPlaylistInfo"; // 생성된 플레이리스트 정보 페이지로 이동
        
    //     //return "test/playlist/createOKPlaylist"; // 플레이리스트 생성 완료 페이지로 이동
    // }
    
    // 회원본인의 플레이리스트 조회
    @GetMapping("myPlaylist")
    public String myPlaylist(HttpServletRequest request, Model model) {
    	HttpSession session = request.getSession();
    	User user = (User)session.getAttribute("user");
    	
    	model.addAttribute("playlist", playlistService.myPlaylist(user.getUserEmail()));
    	
    	return "playlist/myPlaylist";
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