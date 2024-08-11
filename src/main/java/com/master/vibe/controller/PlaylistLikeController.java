package com.master.vibe.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PlaylistLikeController {
	
	private int likeCount = 0;
	
	@ResponseBody
	@GetMapping("/like")
	public int likeCount() {
		return ++likeCount;
	}
}