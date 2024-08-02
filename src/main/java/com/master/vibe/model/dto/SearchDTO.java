package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SearchDTO {
	// 전체 검색, 태그 검색
	private String select;
	private String searchPlaylist;
}
