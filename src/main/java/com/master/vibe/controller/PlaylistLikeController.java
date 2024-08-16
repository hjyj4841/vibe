package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistLikeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistLikeController {
	
	@Autowired
	private PlaylistLikeService likeService;
	
	// 내가 좋아요한 플리 조회
	@Autowired
	private PlaylistLikeService playlistLikeService;
	
	@GetMapping("/playlistLike")
	public String playlistLike(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		List<PlaylistLike> list = playlistLikeService.playlistLike(user.getUserEmail());
		model.addAttribute("list", list);
		System.err.println(list);
		return "playlist/mylikelist";
	}
	
	@ResponseBody
	@PostMapping("/like")
	public void likeCheck(HttpServletRequest request, Model model, int code) {
		HttpSession session = request.getSession();

		
	}
}