package com.master.vibe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.Music;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.TagService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaylistController {

	@Autowired
	private PlaylistService playlistService;
	
	@Autowired
	private TagService tagService;
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadPath;

	// 플레이리스트 이미지 업로드 관련 // 서버 연결 관련 차후 보완 필요! 2024.08.16/현호
//	@Value("${file.upload-dir}")
//	private String uploadDir;

	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		System.out.println(fileName);
//	    File copyFile = new File("\\\\192.168.10.6\\vibe\\playlistImg\\" + fileName);
		File copyFile = new File(uploadPath + File.separator + "playlistImg" + File.separator + fileName);
		
		System.out.println(copyFile.getPath());

		file.transferTo(copyFile);
		return fileName;
	}

	// 플레이리스트 전체 조회 페이지
	@GetMapping("/searchHome")
	public String searchAllPlaylist(Model model) {
		SearchDTO dto = new SearchDTO();
		model.addAttribute("allPlaylist", playlistService.allPlaylist(dto));
		return "test/search/searchHome";
	}
    
    // 플레이리스트 생성
    @GetMapping("/createPlaylist")
    public String createPlaylist(Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
    	
		model.addAttribute("user", user);
		
    	return "playlist/createPlaylist";
    }

    @PostMapping("/createPlaylist")
    public String createPlaylist(CreatePlaylistDTO dto, HttpServletRequest request) throws IllegalStateException, IOException {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
        
        if (user == null) {
            return "redirect:/login";
        }
        
		System.out.println(dto.getPlUrl());
		String fileName = fileUpload(dto.getPlUrl());

        dto.setUserEmail(user.getUserEmail());
        
        playlistService.createPlaylist(dto);
		dto.setPlImg("http://localhost:8081/playlistImg/" + fileName);
        
        // 태그 입력값 받기
        List<String> tagNames = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            String tag = request.getParameter("tag" + i);
            if (tag != null && !tag.trim().isEmpty()) {
                tagNames.add(tag.trim());
            }
        }

        // 태그 서비스 호출
        tagService.addTagsByName(tagNames);

        // 플레이리스트와 태그 연동
        int plCode = dto.getPlCode(); // 생성된 플레이리스트 코드 가져오기
        tagService.addPlaylistTags(plCode, tagNames);
        
        return "redirect:/myPlaylist";
    }
    
    @GetMapping("/playlistInfo")
    public String showPlaylistInfo(int plCode, Model model) {
        Playlist playlist = playlistService.getPlaylistByCode(plCode);
        List<String> tagList = playlistService.getTagsByPlaylistCode(plCode);

        model.addAttribute("playlist", playlist);
        model.addAttribute("tagList", tagList);
        
        return "playlist/showPlaylistInfo";
    }
    
    // 회원본인의 플레이리스트 조회
    @GetMapping("/myPlaylist")
    public String myPlaylist(HttpServletRequest request, Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
    	
    	model.addAttribute("playlist", playlistService.myPlaylist(user.getUserEmail()));
    	
    	return "playlist/myPlaylist";
    }
	
    // 플레이리스트 삭제
    @GetMapping("/deletePlaylist")
    public String deletePlaylist(String plCode) {
        playlistService.deletePlaylist(Integer.parseInt(plCode));
        return "redirect:/myPlaylist";
    }
    
    // 플레이리스트 수정 -- 현재는 이름만 수정 가능
    @GetMapping("/updatePlaylist")
    public String updatePlaylist(String plCode, Model model) {
    	
    	model.addAttribute("playlist", 
    			playlistService.selectPlaylistForPlCode(Integer.parseInt(plCode)));
    	
        return "playlist/updatePlaylist";
    }
    
    @PostMapping("/updatePlaylist")
    public String updatePlaylist(Playlist playlist) {
        playlistService.updatePlaylistTitle(playlist);
        return "redirect:/myPlaylist";
    }
    
    // 랭킹 : 좋아요순
    @GetMapping("/likeranking")
    public String likeranking(Model model) {
    	List<Playlist> likeranking = playlistService.likerankingPlaylist();
    	for(Playlist pl : likeranking) {
    		System.out.println(pl);
    	}
    	model.addAttribute("likeranking", likeranking);
		return "ranking/likeranking";
    }

	// 플레이리스트 랜덤 조회
	@GetMapping("/randomPlaylist")
	public String randomPlaylist(Model model) {
		List<Playlist> randomPlaylist = playlistService.randomPlaylist();
		System.out.println(randomPlaylist);
		model.addAttribute("randomPlaylist", randomPlaylist);
		return "playlist/randomPlaylist";
	}

	// 태그 검색 랭킹 조회
	@GetMapping("/searchTag")
	public String searchTag() {
		return "playlist/searchTag";
	}
	@GetMapping("/searchTagRanking")
	public String searchTagRanking(String tagName, Model model) {
		List<Playlist> playlist = playlistService.searchTagRanking(tagName);
		model.addAttribute("searchTagRanking", playlist);
		return "playlist/searchTagRanking";
	}

	// 한달 동안의 플레이리스트 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnMonth")
	public String playListRankingOnMonth(Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnMonth();
		model.addAttribute("playListRankingOnMonth", playlist);
		return "playlist/playListRankingOnMonth";
	}

	// 연령별 좋아요 랭킹 조회
	@GetMapping("/playListRankingOnAgeGroupSelect")
	public String playListRankingOnAgeGroupSelect() {
		return "playlist/playListRankingOnAgeGroupSelect";
	}
	@PostMapping("/playListRankingOnAgeGroup")
	public String playListRankingOnAgeGroup(String ageGroup, Model model) {
		List<Playlist> playlist = playlistService.playListRankingOnAgeGroup(ageGroup);
		model.addAttribute("playListRankingOnAgeGroup", playlist);
		model.addAttribute("ageGroup", ageGroup);
		return "playlist/playListRankingOnAgeGroup";
	}
    
    /*
    @PostMapping("/updatePlaylist")
    public String updatePlaylist(@ModelAttribute PlaylistDTO playlistDTO) {
    	MultipartFile file = playlistDTO.getPlImg();
        if (file != null && !file.isEmpty()) {
            // 파일 처리 로직 (예: 파일 저장)
            String fileName = file.getOriginalFilename();
            // 파일 저장 위치 및 로직을 설정하세요.
            // 예: file.transferTo(new File("/path/to/save/" + fileName));
            // 파일 저장 후, 경로를 DTO에 추가할 수 있습니다.
            // playlistDTO.setPlImgPath("/path/to/save/" + fileName);
        }
        // DTO를 사용하여 업데이트 로직 처리
        playlistService.updatePlaylist(playlistDTO);
        return "redirect:/somePage";
    }
    */
    
    /*
    // 플레이리스트 생성 처리
    @PostMapping("/createPlaylist")
    public String createPlaylist(CreatePlaylistDTO dto, Model model) {
        playlistService.createPlaylist(dto);
        
        // DTO에서 제목을 추출하여 모델에 추가
        model.addAttribute("plTitle", dto.getPlTitle());
        
        // 생성된 플레이리스트 정보 페이지로 이동
        return "test/playlist/createPlaylistInfo";
    }
	*/
}