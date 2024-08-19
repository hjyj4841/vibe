package com.master.vibe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Playlist;
import mapper.PlaylistMapper;

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
	public Playlist selectPlaylistByPlCode(int plCode) {
		return playlistMapper.selectPlaylistByPlCode(plCode);
	}

	// 플레이리스트 생성
	public void createPlaylist(CreatePlaylistDTO dto) {
		playlistMapper.createPlaylist(dto);
		// return playlistMapper.getLastInsertedId(); // 최근 삽입된 플레이리스트의 ID를 반환
	}

	// 플레이리스트 삭제
	public void deletePlaylist(int plCode) {
		playlistMapper.deletePlaylistMusic(plCode);
		playlistMapper.deletePlaylist(plCode);
	}

	// 플레이리스트 수정
	public void updatePlaylist(Playlist playlist) {
		playlistMapper.updatePlaylist(playlist);
	}
//	public void updatePlaylistTitle(Playlist playlist) {
//		playlistMapper.updatePlaylistTitle(playlist);
//	}

	// 랭킹 : 좋아요순
	public List<Playlist> likerankingPlaylist() {
		return playlistMapper.likerankingPlaylist();
	}

	public List<Music> getMusicListByPlaylistCode(int plCode) {
		return null;
	}
	
	// 플레이리스트 코드로 태그 이름 리스트 가져오기
    public List<String> getTagsByPlaylistCode(int plCode) {
        return playlistMapper.findTagsByPlaylistCode(plCode);
    }
    
    // 플레이리스트 랜덤 조회
    public List<Playlist> randomPlaylist(){
    	return playlistMapper.randomPlaylist();
    }
    
    // 검색 태그 랭킹 조회
    public List<Playlist> searchTagRanking(String tagName){
    	return playlistMapper.searchTagRanking(tagName);
    }
    
    // 한달 동안의 플레이리스트 좋아요 랭킹 조회
    public List<Playlist> playListRankingOnMonth(){
    	return playlistMapper.playListRankingOnMonth();
    }
    
    // 연령 그룹별 좋아요 랭킹 조회 
    public List<Playlist> playListRankingOnAgeGroup(String ageGroup) {
    	return playlistMapper.playListRankingOnAgeGroup(ageGroup);
    }
}
