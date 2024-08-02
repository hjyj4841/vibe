package com.master.vibe.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class PlaylistTag {
	private int plTagCode;
	private Playlist playlist;
	private Tag tag;
}
