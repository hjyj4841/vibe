package com.master.vibe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.AddTagDTO;
import com.master.vibe.model.vo.Tag;
import mapper.TagMapper;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;

    public void addTagsToPlaylist(AddTagDTO dto, List<String> tagNames) {
        // 1. 태그가 존재하는지 확인하고, 없으면 추가
        for (String tagName : tagNames) {
            Tag existingTag = tagMapper.findTagByName(tagName);
            if (existingTag == null) {
                tagMapper.insertTag(new Tag(0, tagName));
            }
        }

        // 2. 플레이리스트와 태그를 연결
        for (String tagName : tagNames) {
            Tag tag = tagMapper.findTagByName(tagName);
            if (tag != null) {
                tagMapper.addTagToPlaylist(dto.getPlaylistId(), tag.getTagCode());
            }
        }
    }
}
