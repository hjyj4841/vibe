package com.master.vibe.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	
	// 플레이리스트 이미지 파일 업로드
	private MultipartFile file; // 사실 DTO 따로 만들어서 사용하는 게 원칙!
	
	// 랭킹 : 좋아요순
	private int likeCode;
	
	private List<PlaylistTag> tagList;
	
}
