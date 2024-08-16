package com.master.vibe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.Tag;

import mapper.PlaylistTagMapper;
import mapper.TagMapper;

import java.util.ArrayList;
import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;
    
    @Autowired
    private PlaylistTagMapper playlistTagMapper;

    public void addTagsByName(List<String> tagNames) {
        if (tagNames == null) {
            tagNames = new ArrayList<>();
        }

        for (String tagName : tagNames) {
            List<Tag> existingTags = tagMapper.findTagByName(tagName);
            if (existingTags.isEmpty()) {
                Tag tag = new Tag();
                tag.setTagName(tagName);
                tagMapper.insertTag(tag);
            }
        }
    }

    public List<String> getTagsByPlaylistCode(int plCode) {
        return tagMapper.findTagsByPlaylistCode(plCode);
    }

    public void addPlaylistTags(int plCode, List<String> tagNames) {
        for (String tagName : tagNames) {
            Tag tag = playlistTagMapper.selectTagByName(tagName);
            if (tag != null) {
                playlistTagMapper.insertPlaylistTag(plCode, tag.getTagCode());
            }
        }
    }
}