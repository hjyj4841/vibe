package com.master.vibe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.PlaylistLike;

import mapper.PlaylistLikeMapper;

@Service
public class PlaylistLikeService {

	@Autowired
	private PlaylistLikeMapper like;
	
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
