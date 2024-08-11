package com.master.vibe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.dto.AddTagDTO;
import com.master.vibe.service.TagService;

@Controller
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/addTags")
    public String addTagsPage(@RequestParam("playlistId") int playlistId, Model model) {
        model.addAttribute("playlistId", playlistId);
        return "test/playlist/addTags"; // 태그 추가 페이지로 이동
    }

    @PostMapping("/addTags")
    public String addTags(AddTagDTO dto, @RequestParam List<String> tagNames) {
        tagService.addTagsToPlaylist(dto, tagNames);
        return "test/test"; // 태그 추가 후 리다이렉트할 페이지
    }
}
