package com.master.vibe.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor
public class SearchDTO {
	// 전체 검색, 태그 검색
	private String select;
	private String search;
	private List<Integer> codes;
}
