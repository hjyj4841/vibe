package com.master.vibe.model.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class UpdatePlaylistDTO {

	private int plCode;
	private String plTitle;
	private MultipartFile plImgFile; // 업로드할 파일
}
