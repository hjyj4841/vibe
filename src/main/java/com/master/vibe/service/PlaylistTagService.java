package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistTag;

import mapper.PlaylistTagMapper;

@Service
public class PlaylistTagService {

	@Autowired
	private PlaylistTagMapper playlistTagMapper;
	
	public List<PlaylistTag> searchTagPlaylist(int code) {
		return playlistTagMapper.searchTagPlaylist(code);
	}
	
<<<<<<< Updated upstream
//	호출하는 controller가 없음
//	public List<Playlist> getPlaylistsByTag(String tagCode) {
//		return playlistTagMapper.getPlaylistsByTag(tagCode);
//	}
=======
	public List<Integer> searchTag(String search) {
		return playlistTagMapper.searchTag(search);
	}
	
	
	// 제목 검색, 태그 검색
	//public List<PlaylistTag> searchPlaylist(SearchDTO dto){
	//	return playlistTagMapper.searchPlaylist(dto);
	//}
	
	//public List<Playlist> getPlaylistsByTag(String tagCode) {
	//	return playlistTagMapper.getPlaylistsByTag(tagCode);
	//}
>>>>>>> Stashed changes

}
