package com.master.vibe.model.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;

import lombok.Builder;
import lombok.Data;

@Builder @Data
public class PlaylistDTO {

	private int plCode;
	private String plTitle;
	private String plImg;
	//private MultipartFile plImg; // String -> MultipartFile로 변경. 플리 수정: 이미지 변경 시도
	private Date plDate;
	private char plPublicYn;
	private User user;
	
	private List<PlaylistTag> tagList;
}
