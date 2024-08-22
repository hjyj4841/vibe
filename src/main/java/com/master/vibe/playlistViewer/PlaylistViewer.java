package com.master.vibe.playlistViewer;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistLikeService;
import com.master.vibe.service.PlaylistTagService;

@Component
public class PlaylistViewer {
	
	@Autowired
	private PlaylistTagService playlistTagService;
	
	@Autowired
	private PlaylistLikeService playlistLikeService;
	
	public List<PlaylistDTO> playlistView(List<Playlist> playlist, User user){
		// model에 담을 플레이리스트의 목록들
		List<PlaylistDTO> dtoList = new ArrayList<>();
		
		// 뽑아온 태그를 리스트로 만드는 코드
		for(Playlist play : playlist) {
			List<PlaylistTag> tagList = playlistTagService.searchTagPlaylist(play.getPlCode());
			
			PlaylistLikeDTO plDto = new PlaylistLikeDTO();
			plDto.setPlCode(play.getPlCode());
			plDto.setUserEmail(user.getUserEmail());
			PlaylistLike pLike = playlistLikeService.showPlLikeUser(plDto);
			
			int lCount = playlistLikeService.showLikeCount(play.getPlCode());
			
			PlaylistDTO pDto = PlaylistDTO.builder()
					.plCode(play.getPlCode())
					.plTitle(play.getPlTitle())
					.plImg(play.getPlImg())
					.plPublicYn(play.getPlPublicYn())
					.tagList(tagList)
					.user(User.builder()
							.userNickname(play.getUser().getUserNickname())
							.userImg(play.getUser().getUserImg())
							.build())
					.plLike(pLike)
					.likeCount(lCount)
					.build();
			
			dtoList.add(pDto);
		}
		
		return dtoList;
	}
	
	public PlaylistDTO onePlaylistView(Playlist playlist, User user){
		// model에 담을 플레이리스트의 목록들
		
		// 뽑아온 태그를 리스트로 만드는 코드
		List<PlaylistTag> tagList = playlistTagService.searchTagPlaylist(playlist.getPlCode());
		
		// DTO에 담아서 서비스로 처리
		PlaylistLikeDTO plLikeDto = new PlaylistLikeDTO();
		plLikeDto.setPlCode(playlist.getPlCode());
		plLikeDto.setUserEmail(user.getUserEmail());
		
		// 회원이 해당 플레이리스트를 좋아요 표시했는지 조회
		PlaylistLike pLike = playlistLikeService.showPlLikeUser(plLikeDto);
		
		int lCount = playlistLikeService.showLikeCount(playlist.getPlCode());
			
		System.err.println(lCount);
		
		PlaylistDTO pDto = PlaylistDTO.builder()
				.plCode(playlist.getPlCode())
				.plTitle(playlist.getPlTitle())
				.plImg(playlist.getPlImg())
				.plPublicYn(playlist.getPlPublicYn())
				.tagList(tagList)
				.user(User.builder()
						.userNickname(playlist.getUser().getUserNickname())
						.userImg(playlist.getUser().getUserImg())
						.build())
				.plLike(pLike)
				.likeCount(lCount)
				.build();
			
		System.err.println(pDto);
		
		return pDto;
	}
}
