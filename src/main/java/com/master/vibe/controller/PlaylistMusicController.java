package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.service.PlaylistMusicService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistMusicController {
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
	@Autowired
	private SpotifyService spotifyService;
	
	@Autowired
	private PlaylistService playlistService;
	
	// 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직을 구현
    @PostMapping("/addMusicInPlaylist")
    public String addPlaylist(@RequestParam List<String> selectedMusic, Model model, HttpServletRequest request) {
        // selectedMusic 리스트를 Playlist 객체로 변환하는 로직 필요 -> service에서 구현
    	// 이 예제에서는 단순히 추가된 음악 목록을 출력함
    	HttpSession session = request.getSession();
    	
    	playlistMusicService.addPlaylist(selectedMusic, Integer.parseInt(session.getAttribute("plCode").toString())); // session에 지정되어 있는 pl 코드 넘겨줌
        model.addAttribute("selectedMusic", selectedMusic);
        
        return "test/playlist/addMusicInPlaylist";	// addPlaylist.jsp로 리다이렉트
    }
    
    // ???
    // 플레이리스트 추가 폼 불러오기
    @GetMapping("/playlistMusic")
    public String showAddPlaylistForm(Model model, @RequestParam(value = "selectedMusic", required = false) List<String> selectedMusic) {
        model.addAttribute("selectedMusic", selectedMusic);
        return "test/playlist/playlistMusic";
    }
    
    // 플레이리스트 내 곡 조회
    @GetMapping("/showPlaylistMusic")
    public String showPlaylistMusic(String plCode, Model model) {
    	List<String> musicCode = playlistMusicService.showMusicList(Integer.parseInt(plCode));
    	
    	model.addAttribute("playlist", playlistService.selectPlaylistForPlCode(Integer.parseInt(plCode)));
    	
    	if(musicCode.size() != 0) {
    		List<Music> musicInfo = spotifyService.getMusicINfoForMusicCode(musicCode);
    		model.addAttribute("musicList", musicInfo);
    	}
    	
    	return "test/music/showPlaylistMusic";
    }
    
}