package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;

import mapper.PlaylistLikeMapper;

@Service
public class PlaylistLikeService {
	
	@Autowired
	private PlaylistLikeMapper playlistLikeMapper;
	
	// 내가 좋아요한 플리 조회
	public List<Playlist> likePlaylist(SearchDTO dto) {
		dto.setOffset(dto.getLimit() * (dto.getPage() - 1));
		return playlistLikeMapper.likePlaylist(dto);
	}

	// 좋아요
	public boolean userLike(PlaylistLikeDTO dto) {
		// 조회해서 없으면 추가
		if(playlistLikeMapper.userLikePlaylistCheck(dto) == null) {
			playlistLikeMapper.userLike(dto);
			return true;
		}else {
			// 있으면 삭제
			playlistLikeMapper.userUnLike(dto);
			return false;
		}
	}
	
	// 내가 해당 플리를 좋아했는지 조회
	public PlaylistLike showPlLikeUser(PlaylistLikeDTO dto) {
		return playlistLikeMapper.userLikePlaylistCheck(dto);
	}
	
	public int showLikeCount(int plCode){
		return playlistLikeMapper.showLikeCount(plCode);
	}
}
