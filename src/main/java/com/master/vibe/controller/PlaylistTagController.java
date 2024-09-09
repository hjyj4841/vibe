package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.playlistViewer.PlaylistViewer;

@Controller
public class PlaylistTagController {
	
	@Autowired
	private PlaylistViewer playlistViewer;
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("/searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
 		model.addAttribute("searchTag", playlistViewer.showPlaylistAll(dto, "N"));
 		model.addAttribute("searchRank", playlistViewer.showPlaylistAll(dto, "Y"));
 		model.addAttribute("dto", dto);
 		
 		return "search/searchPlaylist";
 	}
  	
  	// 무한스크롤 컨트롤러
  	@ResponseBody
  	@PostMapping("/limitList")
  	public List<PlaylistDTO> limitList(SearchDTO dto) {
  		return playlistViewer.showPlaylistAll(dto, "N");
  	}
  	
}