package com.master.vibe.model.dto;

import java.util.Date;
import java.util.List;

import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;

import lombok.Builder;
import lombok.Data;

@Builder @Data
public class PlaylistDTO {

	private int plCode;
	private String plTitle;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private User user;
	
	private List<PlaylistTag> tagList;
}