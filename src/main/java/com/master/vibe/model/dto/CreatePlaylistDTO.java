package com.master.vibe.model.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter @AllArgsConstructor
public class CreatePlaylistDTO {
	private String plTitle;
	private String userEmail;
	private String plImg;
	private List<String> tags;
	private MultipartFile plUrl;
	
	public int getPlCode() {
		return 0;
	}
}
