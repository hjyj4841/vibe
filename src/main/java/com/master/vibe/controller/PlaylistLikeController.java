package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
import com.master.vibe.service.PlaylistLikeService;


@Controller
public class PlaylistLikeController {
	
	@Autowired
	private PlaylistLikeService playlistLikeService;
	@Autowired
	private PlaylistViewer playlistViewer;
	
	// 내가 좋아요한 플리 조회
	@GetMapping("/likePlaylist")
	public String likePlaylist(SearchDTO dto, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		dto.setUserEmail(user.getUserEmail());
		
		List<Playlist> playlist = playlistLikeService.likePlaylist(dto);
		
		model.addAttribute("searchTag", playlistViewer.playlistView(playlist));
		
		return "playlist/myLikeList";
	}
	
	@ResponseBody
	@PostMapping("/limitLikeList")
	public List<PlaylistDTO> limitLikeList(SearchDTO dto) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		dto.setUserEmail(user.getUserEmail());
		
		List<Playlist> playlist = playlistLikeService.likePlaylist(dto);
		
		return playlistViewer.playlistView(playlist);
		
	}
	
	@ResponseBody
	@PostMapping("/userLike")
	public boolean userLike(Model model, int plCode) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		PlaylistLikeDTO dto = new PlaylistLikeDTO();
		dto.setPlCode(plCode);
		dto.setUserEmail(user.getUserEmail());
		
		return playlistLikeService.userLike(dto);
	}
}