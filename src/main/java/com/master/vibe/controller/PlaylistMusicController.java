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
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistMusicController {
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
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
//  public String removeMusicFromPlaylist(@RequestParam List<String> selectedDeleteMusic, HttpServletRequest request) {
    	playlistMusicService.deleteMusicFromPlaylist(plCode, selectedDeleteMusic);
    	
    	return "redirect:/showPlaylistInfo?plCode=" + plCode;
    	
    	/*
    	HttpSession session = request.getSession();
    	int plCode = Integer.parseInt(session.getAttribute("plCode").toString());
    	
    	// 플레이리스트 코드와 음악 코드 목록을 서비스에 전달
        playlistMusicService.deleteMusicFromPlaylist(plCode, selectedDeleteMusic);

        return "redirect:/showPlaylistInfo?plCode=" + plCode;
        */
    }
    
    // 사용자가 플레이리스트에 음악 추가 시 추가하려는 음악이 해당 플레이리스트에 이미 있는 곡인지 중복 체크
    @ResponseBody
    @PostMapping("/checkMusicInPlaylist")
    public List<String> checkMusicInPlaylist(@RequestParam List<String> musicId, HttpServletRequest request, String plCode) {
    	
    	// Map 형태로 전달
        return playlistMusicService.getExistingMusicIdInPlaylist(Integer.parseInt(plCode), musicId);
        
        // List로 실패
//    	List<String> existingMusicId = playlistMusicService.getExistingMusicIdInPlaylist(plCode, musicId);
//    	return existingMusicId;
    }
}
