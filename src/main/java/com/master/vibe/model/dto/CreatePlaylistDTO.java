package com.master.vibe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter @AllArgsConstructor
public class CreatePlaylistDTO {
	private String plImg;
	private String plTitle;
	private String userEmail;
}
