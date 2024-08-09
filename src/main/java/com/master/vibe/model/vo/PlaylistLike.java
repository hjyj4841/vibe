package com.master.vibe.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
public class PlaylistLike {
	private int likeCode;
	private Date likeDate;
	private User user;
	private Playlist playlist;
}
