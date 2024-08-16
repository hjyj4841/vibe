package com.master.vibe.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter @AllArgsConstructor
public class CreatePlaylistDTO {
	private String plTitle;
	private String userEmail;
	private String plImg;
	private List<String> tags;
	public int getPlCode() {
		return 0;
	}
}

























