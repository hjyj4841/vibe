package com.master.vibe.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.master.vibe.model.vo.Music;
import com.master.vibe.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class SpotifyController {

	@Autowired
	private SpotifyService spotifyService;
	
	// 플레이리스트 음악 추가
	@GetMapping("/addMusic")
	public String MusicForm(String plCode, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("plCode", plCode);
		
		return "music/musicForm";
	}
	@PostMapping("/addMusic")
	public String getMusic(String musicName, Model model) {
		int offset = 0;
		ArrayList<Music> musicData = spotifyService.getMusicInfoForMusicName(musicName, offset);
		
		model.addAttribute("musicData", musicData);
		return "music/musicInfo";
	}
}
