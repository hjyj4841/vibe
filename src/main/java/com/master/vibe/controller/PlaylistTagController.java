package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
import com.master.vibe.service.PlaylistLikeService;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;

@Controller
public class PlaylistTagController {
	
	@Autowired
	private PlaylistTagService playlistTagService;
	@Autowired
	private PlaylistService playlistService;
	@Autowired
	private PlaylistViewer playlistViewer;
	@Autowired
	private PlaylistLikeService playlistLikeService;
	
	public List<PlaylistDTO> playlist(SearchDTO dto, User user) {
		
		System.out.println(dto);
		dto.setSearch(dto.getSearch().toLowerCase());
  		System.out.println(dto.getSelect()); // title or tag
  		//System.out.println(dto.getSearch().equals("")); // true
  		if(dto.getCodes()!=null && dto.getCodes().get(0) == 0) {
  			dto.setCodes(null);
  		}
  		
  		// 플리 제목 검색이라면 DTO에 검색 내용 대입
  		if(dto.getSelect().equals("tag")) {
  			List<Integer> codes = playlistService.searchTag(dto.getSearch());
  			if(codes.size()!=0) {
  				dto.setCodes(codes);
  			}
  		}

  		// 검색한 내용을 바탕으로 플레이리스트를 담는 리스트 생성
  		List<Playlist> playlist = playlistService.allPlaylist(dto);
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
  			
  			System.out.println(dtoPlay);
  			System.out.println(list);
  			System.out.println(plDto);
  		}
  		
  		return list;
	}
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("/searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
  		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  		User user = new User();
  		
  		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
    		model.addAttribute("user", user);
  		}
  		
 		model.addAttribute("searchTag", playlist(dto, user));
 		model.addAttribute("dto", dto);
 		return "search/searchPlaylist";
 	}
  	
  	
  	@ResponseBody
  	@PostMapping("/limitList")
  	public List<PlaylistDTO> limitList(SearchDTO dto, Model model) {
  		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  		User user = new User();
  		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
    		model.addAttribute("user", user);
  		}
  		
  		System.out.println(dto);
  		return playlist(dto, user);
  	}
  	
  	//@GetMapping("/search")
	//public String getPlaylistsByTag(String tagCode, Model model) {
	//	model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
	//	return "searchtagview";
	//}
}