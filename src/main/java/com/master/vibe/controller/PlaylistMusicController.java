package com.master.vibe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.vo.PlaylistMusic;
import com.master.vibe.service.PlaylistMusicService;

@Controller
public class PlaylistMusicController {
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
	// 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직을 구현
    @PostMapping("/addPlaylist")
    public String addPlaylist(@RequestParam List<String> selectedMusic, @RequestParam String plCode, Model model) {
    	
    	// -- 내가 만든 플레이리스트 조회
    	List<PlaylistMusic> playlistMusicList = new ArrayList<>();
    	for(String musicCode : selectedMusic) {
    		PlaylistMusic pm = new PlaylistMusic();
    		pm.setMusicCode(musicCode);
    		pm.setPlCode(Integer.parseInt(plCode));
    		playlistMusicList.add(pm);
    	}
    	
        // selectedMusic 리스트를 Playlist 객체로 변환하는 로직 필요 -> service에서 구현
    	// 이 예제에서는 단순히 추가된 음악 목록을 출력함
    	System.err.println(selectedMusic);
    	System.err.println(plCode);
    	
    	playlistMusicService.addPlaylist(selectedMusic, Integer.parseInt(plCode));
    	
        model.addAttribute("selectedMusic", selectedMusic);
        
        return "test/playlist/addMusic"; // playlist.jsp로 리다이렉트
    }
    
    // 플레이리스트 추가 폼 불러오기
    @GetMapping("/playlistMusic")
    public String showAddPlaylistForm(Model model, @RequestParam(value = "selectedMusic", required = false) List<String> selectedMusic) {
        model.addAttribute("selectedMusic", selectedMusic);
        return "test/playlist/playlistMusic";
    }
}



















