package com.master.vibe.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class User {
	private String userEmail;
	private String userPassword;
	private String userNickname;
	private String userImg;
	private Date userDate;
	private char userEntYn;
	private char userSpotifyYn;
	private String userGender;
	private Date userBirth;
	private char userManager;
	private Date userEnrollDate;
}
