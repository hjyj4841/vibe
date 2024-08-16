package com.master.vibe.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Playlist {
	private int plCode;
	private String plTitle;
	private String userEmail;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private User user;
	private int likeCount;
	
	// 랭킹 : 좋아요순
	private int likeCode;
	
}
















