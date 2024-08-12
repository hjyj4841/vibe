package com.master.vibe.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.PlaylistMusic;

import mapper.PlaylistMusicMapper;

@Service
public class PlaylistMusicService {
	
	@Autowired
	private PlaylistMusicMapper playlistMusicMapper;
	
	// 선택된 음악 리스트를 처리하여 플레이리스트에 추가하는 로직을 추가할 수 있습니다.
    public void addPlaylist(List<String> selectedMusic, int plCode) {
        // 예를 들어, 선택된 음악의 정보를 기반으로 Playlist 객체를 생성하고, 이를 데이터베이스에 추가하는 로직
    	List<PlaylistMusic> list = new ArrayList<PlaylistMusic>();
    	for(String musicCode : selectedMusic) {
    		PlaylistMusic pm = new PlaylistMusic();
    		pm.setMusicCode(musicCode);
    		pm.setPlCode(plCode);
    		list.add(pm);
    	}
    	playlistMusicMapper.addMusicToPlaylist(list);
    }
    
    // 플레이리스트_뮤직 테이블에서 해당 플레이리스트의 뮤직코드만 조회
    public List<String> showMusicList(int plCode){
    	return playlistMusicMapper.showMusicList(plCode);
    }
    
    
    // 플레이리스트에서 음악 삭제
    public void deleteMusicFromPlaylist(int plCode, List<String> selectedDeleteMusic) {
        playlistMusicMapper.deleteMusicFromPlaylist(plCode, selectedDeleteMusic);
    }
    
}
