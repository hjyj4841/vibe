package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.Playlist;
import mapper.PlaylistMapper;

// 현재 PlaylistService.java는 addPlaylist 메소드를 List<String> 타입으로 오버로딩하고 있지만, 해당 메소드의 내용이 비어 있습니다.
// 이 메소드를 적절히 구현해야 합니다. 플레이리스트를 추가할 때 음악 정보를 다루는 로직을 여기에 추가할 수 있습니다.

@Service
public class PlaylistService {

	@Autowired
	private PlaylistMapper playlistMapper;
	
	// 플레이리스트 전체 조회
	public List<Playlist> allPlaylist() {
		return playlistMapper.allPlaylist();
	}
	
	// 플레이리스트 생성
	public void createPlaylist(CreatePlaylistDTO dto) {
        playlistMapper.createPlaylist(dto);
    }
	
	// 내가 생성한 플레이리스트 조회
	public List<Playlist> myPlaylist(String userEmail) {
		return playlistMapper.myPlaylist(userEmail);
	}
	
	// plcode로 플레이리스트 정보 조회
	public Playlist selectPlaylistForPlCode(int plCode) {
		return playlistMapper.selectPlaylistForPlCode(plCode);
	}
	
}
