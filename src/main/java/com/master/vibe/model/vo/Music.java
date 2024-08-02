package com.master.vibe.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class Music {
	private String id;
	private String albumUrl;
	private String albumName;
	private String artistName;
	private String musicTitle;
}
