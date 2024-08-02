package com.master.vibe.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class PlaylistTag {
	private String plCode;
	private String plName;
	private int likeCount;
	
	public String getTagName() {
		return plCode;
	}
	
	public void setPlCode(String plCode) {
		this.plCode = plCode;
	}
	
	public String getPlName() {
		return plName;
	}
	
	public void setPlName(String plName) {
		this.plName = plName;
	}
	
	public int getLikeCount() {
		return likeCount;
	}
	
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
}











