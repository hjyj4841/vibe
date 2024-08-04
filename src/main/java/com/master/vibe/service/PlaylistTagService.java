package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;

import mapper.PlaylistTagMapper;

@Service
public class PlaylistTagService {

	@Autowired
	private PlaylistTagMapper playlistTagMapper;
	
	// 제목 검색, 태그 검색
	public List<Playlist> searchPlaylist(SearchDTO dto){
		return playlistTagMapper.searchPlaylist(dto);
	}
	
//	호출하는 controller가 없음
//	public List<Playlist> getPlaylistsByTag(String tagCode) {
//		return playlistTagMapper.getPlaylistsByTag(tagCode);
//	}

}
