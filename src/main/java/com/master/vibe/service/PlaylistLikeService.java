package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.PlaylistLike;

import mapper.PlaylistLikeMapper;
import mapper.PlaylistMapper;

@Service
public class PlaylistLikeService {
	
	// 랭킹 : 좋아요순
	@Autowired
	private PlaylistMapper playlistMapper;
	
	
	// 내가 좋아요한 플리 조회
	@Autowired
	private PlaylistLikeMapper playlistLikeMapper;
	
	public List<PlaylistLike> playlistLike(String userEmail) {
		return playlistLikeMapper.likePlaylist(userEmail);
	}
}
