package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.PlaylistTag;

import mapper.PlaylistTagMapper;

@Service
public class PlaylistTagService {

	@Autowired
	private PlaylistTagMapper playlistTagMapper;
	
	public List<PlaylistTag> searchTagPlaylist(int code) {
		return playlistTagMapper.searchTagPlaylist(code);
	}
	
	public List<Integer> searchTag(String search) {
		return playlistTagMapper.searchTag(search);
	}
	
	public void addPlaylistTag(int plCode, int tagCode) {
        playlistTagMapper.insertPlaylistTag(plCode, tagCode);
    }

    public void deletePlaylistTag(int plCode, int tagCode) {
        playlistTagMapper.deletePlaylistTag(plCode, tagCode);
    }
}
