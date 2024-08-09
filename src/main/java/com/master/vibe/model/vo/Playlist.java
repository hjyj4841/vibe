package com.master.vibe.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Playlist {
	private int plCode;
	private String plTitle;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private User user;
	
	// 내가 만든 플레이리스트 조회
	private String userEmail;
	
	public int getPlCode() {
		return plCode;
	}
	
	public void setPlCode(int plCode) {
		this.plCode = plCode;
	}
	
	public String getPlImg() {
		return plImg;
	}
	
	public void setPlImg(String plImg) {
		this.plImg = plImg;
	}
	
	public Date getPlDate() {
		return plDate;
	}
	
	public char getPlPublicYn() {
		return plPublicYn;
	}
	
	public void setPlPublicYn(char plPublicYn) {
		this.plPublicYn = plPublicYn;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
}






















