package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
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
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("/searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
  		SearchDTO search = new SearchDTO();
  		
  		// 플리 제목 검색이라면 DTO에 검색 내용 대입
  		if(dto.getSelect().equals("title")) {
  			search.setSearch(dto.getSearch());
  		// 태그 검색일 때 타이틀을 뽑아옴
  		} else if(dto.getSelect().equals("tag")) {
  			// 검색한 태그명이 포함된 태그를 가진 플레이리스트를 담은 List - pl_code
  			List<Integer> codes = playlistTagService.searchTag(dto.getSearch());
  			if(codes.size()!=0) {
	  				search.setCodes(codes);
	  			} else {
	  				// 조회된 내용이 없을 경우 null 리턴
	  				model.addAttribute("searchTag", null);
	  		 		return "search/searchPlaylist";
	  			}
  		}
  		// 검색한 내용을 바탕으로 플레이리스트를 담는 리스트 생성
  		List<Playlist> playlist = playlistService.allPlaylist(search);
  		
  		// 유저 정보 담기 위한 코드
  		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  		User user = new User();
  		
  		if(!authentication.getName().equals("anonymousUser")) {
    		user = (User) authentication.getPrincipal();
    		model.addAttribute("user", user);
    	}
  		
 		model.addAttribute("searchTag", playlistViewer.playlistView(playlist, user));
 		
 		return "search/searchPlaylist";
 	}
  	
  	//@GetMapping("/search")
	//public String getPlaylistsByTag(String tagCode, Model model) {
	//	model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
	//	return "searchtagview";
	//}
}