package com.master.vibe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.view.RedirectView;

import com.master.vibe.service.TagService;

import jakarta.servlet.http.HttpServletRequest;

import com.master.vibe.model.dto.AddTagDTO;

@Controller
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/addTags")
    public String showAddTagsForm() {
        return "test/addTags";
    }

    @PostMapping("/addTags")
    public RedirectView addTags(HttpServletRequest request) {
        AddTagDTO addTagDTO = new AddTagDTO();
        
        // 태그 값을 받아 DTO에 설정
        List<String> tagNames = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            String tag = request.getParameter("tag" + i);
            if (tag != null && !tag.trim().isEmpty()) {
                tagNames.add(tag.trim()); // 태그 이름을 리스트에 추가
            }
        }

        // TagService로 태그 이름 리스트를 전달하는 로직
        tagService.addTagsByName(tagNames);

        return new RedirectView("/test");
    }
    
}