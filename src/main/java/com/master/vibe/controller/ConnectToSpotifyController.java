package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.vo.User;
import com.master.vibe.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ConnectToSpotifyController {

    private final String clientId = "2ccff21a21fe4c0da9f768d5fe0c5dda"; // app ID
    private final String clientSecret = "73199de72d5a426d82b7b232b3ac906e"; // app Secret
    private final String redirectUri = "http://localhost:8080/callback"; // 콜백 URL

    @Autowired
    private SpotifyService spotifyService;

    @GetMapping("/spotifyConnect")
    public String redirectToSpotify() {
        String scope = "'user-read-private user-read-email user-read-playback-state user-modify-playback-state streaming'";
        return "redirect:https://accounts.spotify.com/authorize?client_id=" + clientId 
                + "&response_type=code&redirect_uri=" + redirectUri 
                + "&scope=" + scope;
    }

    @GetMapping("/callback")
    public String handleSpotifyCallback(@RequestParam("code") String code, HttpServletRequest request) {
        try {
        	HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String accessToken = spotifyService.getAccessToken(code, clientId, clientSecret, redirectUri);
            System.out.println(accessToken);
            session.setAttribute("accessToken", accessToken);
            spotifyService.updateUserSpotifyStatus(user.getUserEmail());
            return "redirect:/userTest"; // 마이페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/error"; // 오류 시 에러 페이지로 리다이렉트
        }
    }
}