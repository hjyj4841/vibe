package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistLikeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistLikeController {
	
	
	@Autowired
	private PlaylistLikeService playlistLikeService;
	
	// 내가 좋아요한 플리 조회
	@GetMapping("/likePlaylist")
	public String likePlaylist(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		model.addAttribute("list", playlistLikeService.likePlaylist(user.getUserEmail()));
		return "playlist/myLikeList";
	}
	
	@ResponseBody
	@PostMapping("/like")
	public void likeCheck(HttpServletRequest request, Model model, int code) {
		HttpSession session = request.getSession();

	}
}