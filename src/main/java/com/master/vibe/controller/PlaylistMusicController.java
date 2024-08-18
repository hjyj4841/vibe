package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	// 선택된 음악 ID를 사용하여 플레이리스트에 추가하는 로직 구현
	// music/musicInfo.jsp : <form action="addMusicToPlaylist" method="post">
    @PostMapping("/addMusicToPlaylist")
    public String addMusicToPlaylist(@RequestParam List<String> selectedMusic, Model model, HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	
    	playlistMusicService.addMusicToPlaylist(selectedMusic, Integer.parseInt(session.getAttribute("plCode").toString())); // session에 지정되어 있는 pl 코드 넘겨줌
        model.addAttribute("selectedMusic", selectedMusic);
        
        return "redirect:/showPlaylistInfo?plCode=" + session.getAttribute("plCode");
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
    public List<String> checkMusicInPlaylist(@RequestParam List<String> musicId, HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	int plCode = Integer.parseInt(session.getAttribute("plCode").toString());
    	
    	// Map 형태로 전달
        return playlistMusicService.getExistingMusicIdInPlaylist(plCode, musicId);
        
        // List로 실패
//    	List<String> existingMusicId = playlistMusicService.getExistingMusicIdInPlaylist(plCode, musicId);
//    	return existingMusicId;
    }
    
    
    /* test 페이지 코드
    // 플레이리스트 추가 폼 불러오기
    @GetMapping("/playlistMusic")
    public String showAddPlaylistForm(Model model, @RequestParam(value = "selectedMusic", required = false) List<String> selectedMusic) {
        model.addAttribute("selectedMusic", selectedMusic);
        return "test/playlist/playlistMusic";
    }
    */
}
