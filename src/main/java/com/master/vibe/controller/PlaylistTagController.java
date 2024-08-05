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
	private PlaylistTagService playlistTagService;
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
 		model.addAttribute("searchTag", playlistTagService.searchPlaylist(dto));
 		return "test/search/searchPlaylist";
 	}
  	
  	@GetMapping("/search")
	public String getPlaylistsByTag(String tagCode, Model model) {
		model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
		return "searchtagview";
	}
}