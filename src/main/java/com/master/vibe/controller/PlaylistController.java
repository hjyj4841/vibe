package com.master.vibe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.service.SpotifyService;

@Controller
public class PlaylistController {
	private SpotifyService spotifyService = new SpotifyService();
	
	public PlaylistController(SpotifyService spotifyService) {
		this.spotifyService = spotifyService;
	}
	
	// @GetMapping("/playlists")
//	public String searchPlaylists(@RequestParam String query) {
//		 return spotifyService.searchPlaylists(query);
//	}
}
