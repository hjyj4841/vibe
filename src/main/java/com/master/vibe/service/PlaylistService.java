package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.Playlist;

import mapper.PlaylistMapper;

@Service
public class PlaylistService {
	
	@Autowired
	private PlaylistMapper mapper;
	
	public List<Playlist> allPlaylist() {
		return mapper.allPlayList();
	}
	
}
