package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DeletePlaylistDTO {
	private String plTitle;
	private String userEmail;
	private int plCode;
}
