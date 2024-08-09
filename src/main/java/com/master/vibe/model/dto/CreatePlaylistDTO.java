package com.master.vibe.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CreatePlaylistDTO {
	private String plTitle;
	private String userEmail;
	private String plImg;
	
	// 내가 만든 플레이리스트 조회
	private Date plDate;
	private String plPublicYn;
	
	public String getPlTitle() {
		return plTitle;
	}
	
	public void setPlTitle(String plTitle) {
		this.plTitle = plTitle;
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
	
	public Date setPlDate(Date plDate) {
		return plDate;
	}
	
	public String getPlPublicYn() {
		return plPublicYn;
	}
	
	public void setPlPublicYn(String plPublicYn) {
		this.plPublicYn = plPublicYn;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
}


































