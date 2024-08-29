package com.master.vibe.model.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor
public class CreatePlaylistDTO {
	private String plCode;
	private String plTitle;
	private String userEmail;
	private String plImg;
	private String plPublicYn;
	private List<String> tags;
	private MultipartFile plUrl;
}
