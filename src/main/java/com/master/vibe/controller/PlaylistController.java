package com.master.vibe.controller;

import com.master.vibe.service.PlaylistService;
import com.master.vibe.model.vo.Playlist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;

    @PostMapping("/createPlaylist")
    public String createPlaylist(@RequestParam("pl_title") String pt, @RequestParam("user_email") String ue) {
        Playlist playlist = new Playlist();
        playlist.setPlTitle(pt);
        playlist.setUserEmail(ue);

        playlistService.createPlaylist(playlist);

        return "redirect:/";
    }
}
