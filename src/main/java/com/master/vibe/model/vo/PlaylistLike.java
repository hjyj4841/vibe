package com.master.vibe.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
@Builder
public class PlaylistLike {
	
    // 내가 좋아요한 플리 조회
	private int likeCode;
	private Date likeDate;
	private User user;
	private Playlist playlist;
}
