package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.SpotifyService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ConnectToSpotifyController {

	private final String clientId = "2ccff21a21fe4c0da9f768d5fe0c5dda"; // app ID
	private final String clientSecret = "73199de72d5a426d82b7b232b3ac906e"; // app Secret
	private final String redirectUri = "http://localhost:8080/callback"; // 콜백 URL

	@Autowired
	private SpotifyService spotifyService;
	
	@Autowired
	private PlaylistService playlistService;

	@GetMapping("/spotifyConnect")
	public String redirectToSpotify() {
		String scope = "user-read-private user-read-email user-read-playback-state user-modify-playback-state streaming";
		return "redirect:https://accounts.spotify.com/authorize?client_id=" + clientId
				+ "&response_type=code&redirect_uri=" + redirectUri + "&scope=" + scope;
	}

	@GetMapping("/callback")
	public String handleSpotifyCallback(@RequestParam("code") String code, Model model) {
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			User user = (User) authentication.getPrincipal();
			String accessToken = spotifyService.getAccessToken(code, clientId, clientSecret, redirectUri);
			System.out.println(accessToken);
			model.addAttribute("token", accessToken);
			spotifyService.updateUserSpotifyStatus(user.getUserEmail());
			return "user/mypage"; // 마이페이지로 리다이렉트
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error"; // 오류 시 에러 페이지로 리다이렉트
		}
	}


	@PostMapping("/saveDeviceId")
	public ResponseEntity<String> saveDeviceId(@RequestParam("deviceId") String deviceId, HttpSession session) {
		try {
			session.setAttribute("spotifyDeviceId", deviceId); // 세션에 deviceId 저장
			return ResponseEntity.ok("Device ID saved");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to save Device ID");
		}
	}
}