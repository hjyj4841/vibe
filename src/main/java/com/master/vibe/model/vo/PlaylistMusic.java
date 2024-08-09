package com.master.vibe.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
public class PlaylistMusic {
	private int pmCode;
	private int plCode;
	private String musicCode;
	
	// 내가 만든 플레이리스트 조회
	public int getPmCode() {
		return pmCode;
	}
	
	public void setPmCode(int pmCode) {
		this.pmCode = pmCode;
	}
	
	public int getPlCode() {
		return plCode;
	}
	
	public void setPlCode(int plCode) {
		this.plCode = plCode;
	}
	
	public String getMusicCode() {
		return musicCode;
	}
	
	public void setMusicCode(String musicCode) {
		this.musicCode = musicCode;
	}
}
