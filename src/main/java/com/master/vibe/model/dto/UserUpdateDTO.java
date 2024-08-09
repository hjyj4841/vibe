package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserUpdateDTO {

	private String userPassword;
	private String userNickname;
	private String userPhone;
	private String userEmail;
}
