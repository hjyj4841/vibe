package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;

import mapper.PlaylistTagMapper;

@Controller
public class PlayListTagController {
	
	@Autowired
	private PlaylistTagService playlistTagService;
	
	@GetMapping("/search")
	public String getPlaylistsByTag(String tagCode, Model model) {
		model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
		return "searchtagview";
	}
}
























