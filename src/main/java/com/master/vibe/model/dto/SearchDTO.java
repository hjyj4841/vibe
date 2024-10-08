package com.master.vibe.model.dto;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @Data
public class SearchDTO {
	// 전체 검색, 태그 검색
	private String select;
	private String search;
	private List<Integer> codes;
	private String userEmail;
	private String ageGroup;
	private String userGender;
	
	private int page = 1;
	private int offset = 0;
	private int limit = 10;
	
}
