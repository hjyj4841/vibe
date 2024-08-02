package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.Playlist;
import mapper.PlaylistMapper;

// 현재 PlaylistService.java는 addPlaylist 메소드를 List<String> 타입으로 오버로딩하고 있지만, 해당 메소드의 내용이 비어 있습니다.
// 이 메소드를 적절히 구현해야 합니다. 플레이리스트를 추가할 때 음악 정보를 다루는 로직을 여기에 추가할 수 있습니다.

@Service
public class PlaylistService {

	@Autowired
	private PlaylistMapper mapper;
	
	public void addPlaylist(Playlist playlist) {
        mapper.addPlaylist(playlist);
    }

	// 선택된 음악 리스트를 처리하여 플레이리스트에 추가하는 로직을 추가할 수 있습니다.
    public void addPlaylist(List<String> selectedMusic) {
        // 예를 들어, 선택된 음악의 정보를 기반으로 Playlist 객체를 생성하고, 이를 데이터베이스에 추가하는 로직
        // 구현 예시
//    	mapper.addPlaylist(selectedMusic);
    }
    
    public void createPlaylist(Playlist playlist) {
        mapper.insertPlaylist(playlist);
       
    }

    public List<Playlist> allPlaylist() {
    	System.out.println(mapper.allPlaylist());
    	return mapper.allPlaylist();
    }
	
	public List<Playlist> allPlaylist() {
		return mapper.allPlayList();
	}
	
}
