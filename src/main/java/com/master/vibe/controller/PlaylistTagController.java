package com.master.vibe.controller;

import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	public List<Playlist> playlist(SearchDTO dto) {
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
  		for(Playlist play : playlist) {
  			play.setTagList(playlistService.searchTagPlayList(play.getPlCode()));
  			System.out.println(play);
  		}
  		
  		return playlist;
	}
	
	// 플레이리스트 검색 페이지 (title or tag)
  	@GetMapping("/searchPlaylist")
 	public String searchPlaylist(Model model, SearchDTO dto) {
 		model.addAttribute("searchTag", playlist(dto));
 		model.addAttribute("dto", dto);
 		return "search/searchPlaylist";
 	}
  	
  	@ResponseBody
  	@PostMapping("/limitList")
  	public List<Playlist> limitList(SearchDTO dto) {
  		System.out.println(dto);
  		return playlist(dto);
  	}
  	
  	//@GetMapping("/search")
	//public String getPlaylistsByTag(String tagCode, Model model) {
	//	model.addAttribute("list", playlistTagService.getPlaylistsByTag(tagCode));
		
	//	return "searchtagview";
	//}
}