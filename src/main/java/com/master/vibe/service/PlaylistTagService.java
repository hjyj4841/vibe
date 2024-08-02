package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.Playlist;

import mapper.PlaylistTagMapper;

@Service
public class PlaylistTagService {

	@Autowired
	private PlaylistTagMapper mapper;
	
	public List<Playlist> getPlaylistsByTag(String tagCode) {
		
		return mapper.getPlayLikesByTagLikeCount(tagCode);
	}

}