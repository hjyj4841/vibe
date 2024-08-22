package com.master.vibe.model.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data @AllArgsConstructor
public class CreatePlaylistDTO {
	private String plTitle;
	private String userEmail;
	private String plImg;
	private List<String> tags;
	private MultipartFile plUrl;
	
}
