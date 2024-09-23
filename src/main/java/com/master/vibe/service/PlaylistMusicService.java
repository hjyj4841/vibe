package com.master.vibe.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.MusicPaging;
import com.master.vibe.model.vo.PlaylistMusic;

import mapper.PlaylistMusicMapper;

@Service
public class PlaylistMusicService {
	
	@Autowired
	private PlaylistMusicMapper playlistMusicMapper;
	
	// 선택된 음악 리스트를 플레이리스트에 추가
    public void addMusicToPlaylist(List<String> selectedMusic, int plCode) {
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
    public List<String> showMusicList(MusicPaging paging){
    	paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
    	return playlistMusicMapper.showMusicList(paging);
    }
    
    // 플레이리스트에서 선택한 음악 삭제
    public void deleteMusicFromPlaylist(int plCode, List<String> selectedDeleteMusic) {
        playlistMusicMapper.deleteMusicFromPlaylist(plCode, selectedDeleteMusic);
    }
    
    // 플레이리스트에서 이미 존재하는 musicId 조회
    public List<String> getExistingMusicIdInPlaylist(int plCode, List<String> musicId) {
    	Map<String, Object> params = new HashMap<>(); // 파라미터 저장할 Map 객체 생성
    		params.put("plCode", plCode);
    		params.put("musicId", musicId);
	    return playlistMusicMapper.getExistingMusicIdInPlaylist(params); // 플레이리스트에 이미 존재하는 musicId 리스트 리턴
    }
    
}

