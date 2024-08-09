package com.master.vibe.model.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class FindUserPWDDTO {
	
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date userBirth;
	private String userPhone;
	private String userEmail;
	private String userPassword;
}
