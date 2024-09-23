package com.master.vibe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.service.PlaylistMusicService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PlaylistMusicController {
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
	// 플레이리스트에 음악 추가
	@ResponseBody
    @PostMapping("/addMusicToPlaylist")
    public void addMusicToPlaylist(@RequestParam List<String> selectedMusic, Model model, String plCode) {
		playlistMusicService.addMusicToPlaylist(selectedMusic, Integer.parseInt(plCode));
        model.addAttribute("selectedMusic", selectedMusic);
    }
    
    @ResponseBody
    @GetMapping("/addOneMusic")
    public boolean addOneMusic(String plCode, String musicId) {
    	List<String> musicList = new ArrayList<String>();
    	musicList.add(musicId);
    	
    	List<String> userGotMusic = playlistMusicService.getExistingMusicIdInPlaylist(Integer.parseInt(plCode), musicList);
    	if(userGotMusic.contains(musicId)) {
    		return false;
    	}
    	
    	playlistMusicService.addMusicToPlaylist(musicList, Integer.parseInt(plCode));
        return true;
    }
        
    // 선택한 음악 플레이리스트에서 삭제
    @PostMapping("/deleteMusicFromPlaylist")
    public String deleteMusicFromPlaylist(@RequestParam List<String> selectedDeleteMusic, @RequestParam int plCode) {
    	playlistMusicService.deleteMusicFromPlaylist(plCode, selectedDeleteMusic);
    	return "redirect:/showPlaylistInfo?plCode=" + plCode;
    }
    
    // 사용자가 추가하려는 음악이 해당 플레이리스트에 이미 존재하는지 중복 체크
    @ResponseBody
    @PostMapping("/checkMusicInPlaylist")
    public List<String> checkMusicInPlaylist(@RequestParam List<String> musicId, HttpServletRequest request, String plCode) {
    	// 플레이리스트에 존재하는 musicId 리턴
        return playlistMusicService.getExistingMusicIdInPlaylist(Integer.parseInt(plCode), musicId);
    }
}

