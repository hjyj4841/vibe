package com.master.vibe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.PlaylistTag;
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

    public List<Integer> addTagsByName(List<String> tagNames) {
        if (tagNames == null) {
            tagNames = new ArrayList<>();
        }

        List<Integer> tagCodes = new ArrayList<>();
        for (String tagName : tagNames) {
            Tag existingTag = tagMapper.findTagByName(tagName);
            if(existingTag!=null) {
            	System.out.println("exist!!");
            	tagCodes.add(existingTag.getTagCode());
            } else {
            	Tag tag = new Tag();
            	tag.setTagName(tagName);
            	tagMapper.insertTag(tag);
            	tagCodes.add(tag.getTagCode());
            }
        }
        return tagCodes;
    }

    public void addPlaylistTags(int plCode, List<Integer> tagCodes) {
        for (int code : tagCodes) {
            playlistTagMapper.insertPlaylistTag(plCode, code);
        }
    }

    private static final int MAX_TAGS = 5;
    
    public Tag addTag(String tagName) {
        Tag existingTag = tagMapper.findTagByName(tagName);
        if (existingTag != null) {
            return existingTag;
        } else {
            Tag tag = new Tag();
            tag.setTagName(tagName);
            tagMapper.insertTag(tag);
            return tag;
        }
    }
    
    public List<String> getTagsByPlaylistCode(int plCode) {
        return tagMapper.findTagsByPlaylistCode(plCode);
    }

    public List<Tag> getAllTags() {
        return tagMapper.findAllTags();
    }
    
    public boolean isTagExistsInPlaylist(int plCode, String tagName) {
        List<String> existingTags = tagMapper.findTagsByPlaylistCode(plCode);
        return existingTags.contains(tagName);
    }

    public boolean canAddMoreTags(int plCode) {
        List<PlaylistTag> existingTags = playlistTagMapper.searchTagPlaylist(plCode);
        return existingTags.size() < MAX_TAGS;
    }
}