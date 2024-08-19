package com.master.vibe.model.dto;

import java.util.Date;
import java.util.List;

import com.master.vibe.model.vo.PlaylistLike;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder @Data
public class PlaylistDTO {

	private int plCode;
	private String plTitle;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private User user;
	private PlaylistLike plLike; // 좋아요 했는지 확인용
	private int likeCount; // 해당 플리의 좋아요 수
	private List<PlaylistTag> tagList;
	
	// 랭킹 : 좋아요순
	private int likeCode;
}
