package com.master.vibe.model.dto;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//@Alias("GetUserByIdDTO")
public class GetUserByIdDTO {
	private int plCode;
	private String plTitle;
	private String plImg;
	private Date plDate;
	private char plPublicYn;
	private User user;
	private PlaylistLike plLike; // 좋아요 했는지 확인용
	private int likeCount; // 해당 플리의 좋아요 수
	private List<UserLikeTagDTO> likeTagList;
	private List<PlaylistDTO> getPlayListById;

	// 랭킹 : 좋아요순
	private int likeCode;

}
