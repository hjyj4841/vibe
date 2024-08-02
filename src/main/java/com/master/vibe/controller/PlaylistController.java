package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.master.vibe.model.vo.Playlist;
import com.master.vibe.service.PlaylistService;

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService service;
	
	@GetMapping("/")
	public String index(Model model) {
		
		List<Playlist> list = service.allPlaylist();
		model.addAttribute("allPlaylist", list);
		
		return "index";
	}
	

}














