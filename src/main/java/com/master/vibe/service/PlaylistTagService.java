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
	private PlaylistTagMapper mapper;
	
// 전체 검색, 태그 검색
	public List<Playlist> tagPlaylist(SearchDTO dto){
		return mapper.search(dto);
	}
	public List<Playlist> getPlaylistsByTag(String tagCode) {
		
		return mapper.getPlayLikesByTagLikeCount(tagCode);
	}

}
