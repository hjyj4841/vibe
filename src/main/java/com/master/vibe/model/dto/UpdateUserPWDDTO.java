package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UpdateUserPWDDTO {

	private String userEmail;
	private String userPassword;
}
