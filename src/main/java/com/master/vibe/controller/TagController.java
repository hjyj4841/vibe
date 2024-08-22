package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;
import com.master.vibe.service.TagService;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.Tag;

import java.util.List;

@Controller
public class TagController {

    @Autowired
    private TagService tagService;

    @Autowired
    private PlaylistTagService playlistTagService;

    @Autowired
    private PlaylistService playlistService;

    @GetMapping("/playlist/manageTags")
    public String manageTags(Integer plCode, Model model) {
        model.addAttribute("playlistCode", plCode);

        // 플레이리스트에 연결된 기존 태그들
        List<PlaylistTag> existingTags = playlistTagService.searchTagPlaylist(plCode);
        model.addAttribute("existingTags", existingTags);

        // 모든 태그 목록을 가져와서 태그 추가 시 사용
        List<Tag> allTags = tagService.getAllTags();
        model.addAttribute("allTags", allTags);

        return "playlist/insertAndDeleteTag";
    }

    @PostMapping("/playlist/addTag")
    public String addTag(Integer plCode, String newTag) {
        Tag tag = tagService.addTag(newTag);
        playlistTagService.addPlaylistTag(plCode, tag.getTagCode());
        
        return "redirect:/playlist/manageTags?plCode=" + plCode;
    }

    @PostMapping("/playlist/deleteTags")
    public String deleteTags(Integer plCode, @RequestParam List<Integer> tagCodes) {

    	if (tagCodes != null) {
            for (int tagCode : tagCodes) {
                playlistTagService.deletePlaylistTag(plCode, tagCode);
            }
        }

        return "redirect:/playlist/manageTags?plCode=" + plCode;
    }
}
