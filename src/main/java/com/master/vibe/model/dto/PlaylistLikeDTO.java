package com.master.vibe.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class PlaylistLikeDTO {
	private int plCode;
	private String userEmail;
}
