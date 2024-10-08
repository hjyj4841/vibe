package com.master.vibe.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.dto.UserDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.User;
import com.master.vibe.playlistViewer.PlaylistViewer;
import com.master.vibe.service.PlaylistService;
import com.master.vibe.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	// 각 유저별 프리뷰 이미지 저장할 디렉토리 주소
	private final String previewDir = "\\\\192.168.10.6\\vibe\\img\\preview_img\\";
	private final String UserImgDir = "\\\\192.168.10.6\\vibe\\img\\user_img\\";

	@Autowired
	private UserService userService;

	@Autowired
	private PlaylistService playlistService;

	@Autowired
	private PlaylistViewer playlistViewer;
	

	// 프리뷰 폴더 삭제 메서드
	public void deletePreviewImg() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		File dir = new File(previewDir + user.getUserEmail());
		while (dir.exists()) {
			File[] dirList = dir.listFiles();
			for (File file : dirList)
				file.delete();
			if (dirList.length == 0 && dir.isDirectory())
				dir.delete();
		}
	}

	// 메인페이지 연결
	@GetMapping("/")
	public String index(Model model) {
		List<Playlist> playlist = playlistService.rankTop();
		model.addAttribute("rankTop", playlistViewer.playlistView(playlist));
		return "index";
	}

	// alert 메세지 띄워줄 페이지
	@GetMapping("/msgPage")
	public String msgPage() {
		return "msgPage";
	}

	// 회원가입
	@GetMapping("/registerUser")
	public String register() {
		return "user/registerUser";
	}

	@PostMapping("/registerUser")
	public String register(User user, String birthDay, Model model) {
		// 입력받은 회원의 생일정보 포맷을 변경
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {
		}

		if (userService.register(user) == 1)
			model.addAttribute("registerMsg", "회원가입에 성공 하였습니다.");
		else
			model.addAttribute("registerMsg", "회원가입에 실패 하였습니다.");

		return "msgPage";
	}

	// 로그인
	@GetMapping("/login")
	public String login() {
		return "user/login";
	}

	// 로그인 에러 시 리턴할 메세지
	@GetMapping("/loginError")
	public String loginError(Model model, String error, String username) {
		if (error.equals("탈퇴회원"))
			error = "재가입까지 " + userService.rejoinDate(username) + "일 남았습니다.";

		model.addAttribute("msg", error);
		return "user/login";
	}

	// 계정 찾기 페이지로 이동
	@GetMapping("/findUser")
	public String findUser() {
		return "user/findUser";
	}

	// 계정 찾기 - ID or PASSWORD
	@ResponseBody
	@PostMapping("/findUser")
	public String findUserAccount(User user, String birthDay, Model model) {
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {
		}
		user = userService.findUserAccount(user);

		if (user == null)
			return null;
		return user.getUserEmail();
	}

	// 비밀번호 수정 - PASSWORD 찾기 이후 이어지는 메서드
	@ResponseBody
	@PostMapping("/updateUserPWD")
	public void updateUserPWD(User user) {
		userService.updateUserPWD(user);
	}

	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		// 유저가 좋아하는 태그 top 5
		List<UserLikeTagDTO> list = userService.userLikeTag(user.getUserEmail());
		model.addAttribute("likeTagList", list);

		// 해당유저의 좋아요가 가장 많은 플레이리스트
		try {
			Playlist playlist = playlistService.likeRankByUserEmail(user.getUserEmail());
			model.addAttribute("topPlaylist", playlistViewer.onePlaylistView(playlist));
		} catch (Exception e) {
			model.addAttribute("topPlaylist", null);
		}

		// 랜덤 플레이리스트 하나 보여주기
		try {
			Playlist playlist = playlistService.randomPlaylist(user.getUserEmail()).get(0);
			model.addAttribute("randomPlaylist", playlistViewer.onePlaylistView(playlist));
		} catch (Exception e) {
			model.addAttribute("randomPlaylist", null);
		}
		return "user/mypage";
	}

	// 비밀번호 변경
	@GetMapping("/changePassword")
	public String changePassword() {
		return "user/changePwd";
	}

	@PostMapping("/changePassword")
	public String changePassword(String changePassword, Model model, HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		user.setUserPassword(changePassword);

		userService.updateUserPWD(user);
		model.addAttribute("pwdChange", "패스워드가 변경되었습니다. 다시 로그인 해주세요.");

		// 패스워드 변경시 세션 제거 후 로그아웃
		HttpSession session = request.getSession(false);
		session.invalidate();
		SecurityContextHolder.getContext().setAuthentication(null);
		return "msgPage";
	}

	// 회원탈퇴
	@ResponseBody
	@PostMapping("/deleteUser")
	public boolean deleteUser(String userPassword, Model model, HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		if (userService.deleteUser(user, userPassword)) {
			HttpSession session = request.getSession(false);
			session.invalidate();
			SecurityContextHolder.getContext().setAuthentication(null);
			return true;
		}
		return false;
	}

	// 내 프로필 공유하기
	@GetMapping("/shareMyProfile")
	public String shareMyProfile() {
		return "user/shareMyProfile";
	}

	// ajax - 회원가입시 아이디 중복 조회
	@ResponseBody
	@PostMapping("/emailCheck")
	public boolean emailCheck(String userEmail) {
		return userService.emailCheck(userEmail);
	}

	// ajax - 회원가입시 닉네임 중복 조회
	@ResponseBody
	@PostMapping("/nicknameCheck")
	public boolean nicknameCheck(String userNickname) {
		return userService.nicknameCheck(userNickname);
	}

	// ajax - 회원정보 수정 시 닉네임 중복 조회
	@ResponseBody
	@PostMapping("/nicknameUpdate")
	public boolean nicknameUpdate(String userNickname) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		User u = null;

		try {
			u = user.clone();
		} catch (Exception e) {
		}

		u.setUserNickname(userNickname);

		return userService.nicknameUpdate(u);
	}

	// 회원정보 변경 시 패스워드 확인 - ajax
	@ResponseBody
	@PostMapping("/passwordCheck")
	public boolean passwordCheck(String userPassword) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		User u = null;

		try {
			u = user.clone();
		} catch (CloneNotSupportedException e) {
		}

		return userService.passwordCheck(u, userPassword);
	}

	// ajax - 회원정보 수정시 회원 이미지 바꿔서 보여줌
	@ResponseBody
	@PostMapping("/previewImg")
	public String previewImg(MultipartFile file) throws IllegalStateException, IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();

		// 프리뷰 폴더 경로 지정하는 파일 객체 생성
		String path = previewDir + user.getUserEmail();
		File dir = new File(path);
		// 폴더가 없으면 폴더 생성
		if (!dir.exists())
			dir.mkdir();

		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		File copyFile = new File(path + "\\" + fileName);

		file.transferTo(copyFile);
		return "http://192.168.10.6:8080/img/preview_img/" + user.getUserEmail() + "/" + fileName;
	}

	// 회원 수정
	@GetMapping("/updateUser")
	public String updateUser() {
		return "user/updateUser";
	}

	@PostMapping("/updateUser")
	public String updateUser(UserDTO dto, Model model) throws IllegalStateException, IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		User changeUser = null;
		try {
			changeUser = user.clone();
		} catch (CloneNotSupportedException e) {
		}

		deletePreviewImg();

		// 이미지 변경 로직
		if (!dto.getFile().isEmpty()) {
			// 이전에 가지고 있던 유저 이미지가 기본이미지가 아니라면 삭제
			if (!user.getUserImg().equals("http://192.168.10.6:8080/img/user_img/default_user.jpg")) {
				File deleteFile = new File(UserImgDir + new File(user.getUserImg()).getName());
				deleteFile.delete();
			}
			// 파일 이름 랜덤으로 새로 생성
			UUID uuid = UUID.randomUUID();
			String fileName = uuid.toString() + "_" + dto.getFile().getOriginalFilename();
			File copyFile = new File(UserImgDir + fileName);
			dto.getFile().transferTo(copyFile);

			// 서비스 넘기기 전에 user 객체에 DB에 들어갈 img 경로 지정
			changeUser.setUserImg("http://192.168.10.6:8080/img/user_img/" + fileName);
		} else
			changeUser.setUserImg(dto.getUserImg());
		// 그 외 변경할 정보들을 현재접속한 유저 객체에 담아서 서비스로 처리
		changeUser.setUserNickname(dto.getUserNickname());
		changeUser.setUserPhone(dto.getUserPhone());
		userService.updateUser(changeUser);

		// 변경된 정보로 session에 다시 담기
		UserDetails updateUserDetails = changeUser;
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(updateUserDetails,
				authentication.getCredentials(), updateUserDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(newAuth);

		return "redirect:/mypage";
	}

	// 수정 취소
	@GetMapping("/cancelUpdate")
	public String cancelUpdate() {
		deletePreviewImg();
		return "redirect:/mypage";
	}

	// 공유 용 유저 페이지
	@GetMapping("/profile/{userId}")
	public String getProfile(@PathVariable("userId") String userId, Model model) {
		User user = userService.getUserById(userId);
		model.addAttribute("user",user);
		
		List<UserLikeTagDTO> likeTag = userService.userLikeTag(userId);
		model.addAttribute("likeTag", likeTag);
		
		SearchDTO searchDTO = new SearchDTO();
		
		searchDTO.setUserEmail(userId);
		searchDTO.setLimit(5);
		searchDTO.setPage(1);
		
		List<Playlist> playList = playlistService.myPlaylist(searchDTO);
		
		List<PlaylistDTO> playlistView = playlistViewer.playlistView(playList);
		playlistView.sort(Comparator.comparing(PlaylistDTO::getLikeCount).reversed());
		
		model.addAttribute("playlistView", playlistView);
		
		return "user/profile";
	}
}