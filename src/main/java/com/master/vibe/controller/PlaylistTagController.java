package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.PlaylistTagService;

@Controller
public class PlaylistTagController {
	
	@Autowired
	private PlaylistTagService playlistTagService;
	@Autowired
	private PlaylistService playlistService;
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
  		
  		System.out.println(dto.getSelect()); // 선택???? -> title, tag
  		System.out.println(dto.getSearch()); // 검색된 키워드 
  		
  		List<Playlist> playlist = new ArrayList<>();
  		
  		SearchDTO search = new SearchDTO();
  		
  		// 타이틀 검색일 때 타이틀을 뽑아옴
  		List<PlaylistDTO> dtoList = new ArrayList<>();
  		if(dto.getSelect().equals("title")) {
  			search.setSearch(dto.getSearch());
  		// 태그 검색일 때 타이틀을 뽑아옴
  		} else if(dto.getSelect().equals("tag")) {
  			List<Integer> codes = playlistTagService.searchTag(dto.getSearch());
  			if(codes.size()!=0) {
	  				search.setCodes(codes);
	  			} else {
	  				model.addAttribute("searchTag", null);
	  		 		return "test/search/searchPlaylist";
	  			}
  		}
  		
  		// 뽑아온 타이틀로 리스트 만듬
  		playlist = playlistService.allPlaylist(search);
  		
  		// 뽑아온 태그를 리스트로 만드는 코드
  		for(Playlist play : playlist) {
  			System.out.println(play.getPlCode());
 
  			List<PlaylistTag> tagList = playlistTagService.searchTagPlaylist(play.getPlCode());
  			PlaylistDTO pDto = PlaylistDTO.builder()
  					.plCode(play.getPlCode())
  					.plTitle(play.getPlTitle())
  					.plImg(play.getPlImg())
  					.tagList(tagList)
  					.user(User.builder()
  							.userNickname(play.getUser().getUserNickname())
  							.userImg(play.getUser().getUserImg())
  							.build())
  					.build();
  			dtoList.add(pDto);
  		}
  		
  		System.out.println(dtoList);
 
 		model.addAttribute("searchTag", dtoList);
 		return "test/search/searchPlaylist";
 	}
  	
  	//@GetMapping("/search")
	//public String getPlaylistsByTag(String tagCode, Model model) {
	//	model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
	//	return "searchtagview";
	//}
}