package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.service.PlaylistTagService;

@Controller
public class PlaylistTagController {
	
	@Autowired
	private PlaylistTagService service;
	
	// 전체 검색, 태그 검색
	@GetMapping("search")
	public String search(Model model, SearchDTO dto) {
		model.addAttribute("searchTag", service.tagPlaylist(dto));
		return "search";
	}
}