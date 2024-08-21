package com.master.vibe.model.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserDTO {
	private String userEmail;
	private String userPassword;
	private String userNickname;
	private String userImg;
	private String userPhone;
	
	private MultipartFile file;
}
