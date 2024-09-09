package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.service.SpotifyService;

@Controller
public class MusicListenController {

    private final String clientId = "2ccff21a21fe4c0da9f768d5fe0c5dda"; // Spotify 앱의 Client ID
    private final String clientSecret = "73199de72d5a426d82b7b232b3ac906e"; // Spotify 앱의 Client Secret
    private final String redirectUri = "http://localhost:8080/musicListen/callback"; // 콜백 URL

    @Autowired
    private SpotifyService spotifyService;
    
    // Spotify 인증을 위한 리다이렉트 요청
    @GetMapping("/musicListen")
    public String redirectToSpotifyForMusicPlayer() {
        String scope = "user-read-private user-read-email user-read-playback-state user-modify-playback-state streaming";
        return "redirect:https://accounts.spotify.com/authorize?client_id=" + clientId
                + "&response_type=code&redirect_uri=" + redirectUri + "&scope=" + scope;
    }

    // Spotify 콜백 처리
    @GetMapping("/musicListen/callback")
    public String handleSpotifyCallbackForMusicPlayer(@RequestParam("code") String code, Model model) {
        try {
            String accessToken = spotifyService.getAccessToken(code, clientId, clientSecret, redirectUri);
            model.addAttribute("token", accessToken);
            return "music/musicListen"; // musicListen 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 에러 발생 시 에러 페이지로 리다이렉트
        }
    }
}