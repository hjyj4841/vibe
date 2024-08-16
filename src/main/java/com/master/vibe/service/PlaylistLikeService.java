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
	
	@Autowired
	private PlaylistLikeMapper like;
	
	// 내가 좋아요한 플리 조회
	@Autowired
	private PlaylistLikeMapper playlistLikeMapper;
	
	public List<PlaylistLike> playlistLike(String userEmail) {
		return playlistLikeMapper.likePlaylist(userEmail);
	}

	// 좋아요
	public void playlistLike(PlaylistLike vo) {
		like.playlistLike(vo);
	}
	// 좋아요 테이블 추가
	public PlaylistLike plLike(PlaylistLike vo) {
		return like.plLike(vo);
	}
	
	// 좋아요 취소
	public int likeCode(int code) {
		return like.cancle(code);
	}
	
	// 좋아요 수
	public int likeCount(int code) {
		return like.likeCount(code);
	}
}
