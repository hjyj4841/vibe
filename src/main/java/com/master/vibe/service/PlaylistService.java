package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import mapper.PlaylistMapper;

// 플레이리스트 추가 시 음악 정보를 다루는 로직

@Service
public class PlaylistService {

    @Autowired
    private PlaylistMapper playlistMapper;
    
    // 플레이리스트 전체 조회
    public List<Playlist> allPlaylist(SearchDTO dto) {
        return playlistMapper.allPlaylist(dto);
    }
	
	// 내가 생성한 플레이리스트 조회
	public List<Playlist> myPlaylist(String userEmail) {
		return playlistMapper.myPlaylist(userEmail);
	}
	
	// plcode로 플레이리스트 정보 조회
	public Playlist selectPlaylistForPlCode(int plCode) {
		return playlistMapper.selectPlaylistForPlCode(plCode);
	}
	
	 // 플레이리스트 생성
	 public void createPlaylist(CreatePlaylistDTO dto) {
	    playlistMapper.createPlaylist(dto);
	    //return playlistMapper.getLastInsertedId(); // 최근 삽입된 플레이리스트의 ID를 반환
	 }
    
    // 플레이리스트 삭제
    public void deletePlaylist(int plCode) {
        playlistMapper.deletePlaylist(plCode);
    }
    
    // 플레이리스트 수정
    public void updatePlaylistTitle(Playlist playlist) {
        playlistMapper.updatePlaylistTitle(playlist);
    }

}
