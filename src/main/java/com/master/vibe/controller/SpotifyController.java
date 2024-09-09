package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.vo.Music;
import com.master.vibe.service.SpotifyService;

@Controller
public class SpotifyController {

	@Autowired
	private SpotifyService spotifyService;
	
	// 플레이리스트 음악 추가
	@GetMapping("/addMusic")
	public String MusicForm(String plCode, Model model) {
		model.addAttribute("plCode", plCode);
		return "music/musicForm";
	}
	
	@ResponseBody
	@GetMapping("/showMusic")
	public List<Music> getMusic(String musicName, int offset) {
		List<Music> musicData = spotifyService.getMusicInfoForMusicName(musicName, offset);
		return musicData;
	}
}
