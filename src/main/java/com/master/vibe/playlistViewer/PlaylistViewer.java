package com.master.vibe.playlistViewer;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.MusicPaging;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistLikeService;
import com.master.vibe.service.PlaylistMusicService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;

@Component
public class PlaylistViewer {
	
	@Autowired
	private PlaylistTagService playlistTagService;
	
	@Autowired
	private PlaylistLikeService playlistLikeService;
	
	@Autowired
	private PlaylistService playlistService;
	
	@Autowired
	private PlaylistMusicService playlistMusicService;
	
	public List<PlaylistDTO> showPlaylistAll(SearchDTO dto, String rankYn) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  		User user = new User();
  		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
  		}
		
		dto.setSearch(dto.getSearch().toLowerCase());
		
  		if(dto.getCodes()!=null && dto.getCodes().get(0) == 0) {
  			dto.setCodes(null);
  		}
  		
  		// 플리 태그 검색이라면 DTO에 검색 내용 대입
  		if(dto.getSelect().equals("tag")) {
  			List<Integer> codes = playlistService.searchTag(dto.getSearch());
  			if(codes.size()!=0) {
  				dto.setCodes(codes);
  			}
  		}

  		// 검색한 내용을 바탕으로 플레이리스트를 담는 리스트 생성
  		List<Playlist> playlist = new ArrayList<Playlist>();
		if(rankYn.equals("N")) {
			playlist = playlistService.allPlaylist(dto);
		}else {
			playlist = playlistService.rankPlaylist(dto);
		}
  				
  		List<PlaylistDTO> list = new ArrayList<>();
  		for(Playlist play : playlist) {
  			PlaylistDTO dtoPlay = PlaylistDTO.builder()
  					.plCode(play.getPlCode())
  					.plDate(play.getPlDate())
  					.plTitle(play.getPlTitle())
  					.plImg(play.getPlImg())
  					.plPublicYn(play.getPlPublicYn())
  					.user(play.getUser())
  					.build();
  			
  			PlaylistLikeDTO plDto = new PlaylistLikeDTO();
  			plDto.setPlCode(play.getPlCode());
  			plDto.setUserEmail(user.getUserEmail());
  			dtoPlay.setLikeCount(playlistLikeService.showLikeCount(play.getPlCode()));
  			dtoPlay.setPlLike(playlistLikeService.showPlLikeUser(plDto));
  			dtoPlay.setTagList(playlistService.searchTagPlayList(play.getPlCode()));
  			list.add(dtoPlay);
  		}
  		return list;
	}
	
	public List<PlaylistDTO> playlistView(List<Playlist> playlist){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = new User();
		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
  		}
		
		// model에 담을 플레이리스트의 목록들
		List<PlaylistDTO> list = new ArrayList<>();
  		for(Playlist play : playlist) {
  			PlaylistDTO dtoPlay = PlaylistDTO.builder()
  					.plCode(play.getPlCode())
  					.plDate(play.getPlDate())
  					.plTitle(play.getPlTitle())
  					.plImg(play.getPlImg())
  					.plPublicYn(play.getPlPublicYn())
  					.musicCount(play.getMusicCount())
  					.localCount(play.getLikeCount())
  					.user(play.getUser())
  					.build();
  			
  			PlaylistLikeDTO plDto = new PlaylistLikeDTO();
  			plDto.setPlCode(play.getPlCode());
  			plDto.setUserEmail(user.getUserEmail());
  			
  			MusicPaging mp = new MusicPaging();
  			mp.setPlCode(play.getPlCode());
  			List<String> pmList = playlistMusicService.showMusicList(mp);
  			if(pmList.size() != 0) {
  				dtoPlay.setMusicCode(pmList.get(0));
  			}
  			
  			dtoPlay.setLikeCount(playlistLikeService.showLikeCount(play.getPlCode()));
  			dtoPlay.setPlLike(playlistLikeService.showPlLikeUser(plDto));
  			dtoPlay.setTagList(playlistService.searchTagPlayList(play.getPlCode()));
  			list.add(dtoPlay);
  		}
  		return list;
	}
	
	public PlaylistDTO onePlaylistView(Playlist playlist){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = new User();
		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
  		}
		
		// 뽑아온 태그를 리스트로 만드는 코드
		List<PlaylistTag> tagList = playlistTagService.searchTagPlaylist(playlist.getPlCode());
		
		// DTO에 담아서 서비스로 처리
		PlaylistLikeDTO plLikeDto = new PlaylistLikeDTO();
		plLikeDto.setPlCode(playlist.getPlCode());
		plLikeDto.setUserEmail(user.getUserEmail());
		
		// 회원이 해당 플레이리스트를 좋아요 표시했는지 조회
		PlaylistLike pLike = playlistLikeService.showPlLikeUser(plLikeDto);
		
		int lCount = playlistLikeService.showLikeCount(playlist.getPlCode());
		
		PlaylistDTO pDto = PlaylistDTO.builder()
				.plCode(playlist.getPlCode())
				.plTitle(playlist.getPlTitle())
				.plImg(playlist.getPlImg())
				.plPublicYn(playlist.getPlPublicYn())
				.tagList(tagList)
				.user(User.builder()
						.userEmail(playlist.getUser().getUserEmail())
						.userNickname(playlist.getUser().getUserNickname())
						.userImg(playlist.getUser().getUserImg())
						.build())
				.plLike(pLike)
				.likeCount(lCount)
				.build();
			
		return pDto;
	}
}
