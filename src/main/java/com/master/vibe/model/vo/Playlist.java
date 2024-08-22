package com.master.vibe.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Playlist {
	private int plCode;
	private String plTitle;
	private User user;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private int likeCount;
	
	// 랭킹 : 좋아요순
	private int likeCode;
	
	private List<PlaylistTag> tagList;
	
}
















