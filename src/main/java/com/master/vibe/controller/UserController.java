package com.master.vibe.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.master.vibe.config.DomainFailureHandler;
import com.master.vibe.model.dto.UserDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	// 테스트 페이지 연결
	@GetMapping("/test")
	public String testPage() {
		return "test/test";
	}
	@GetMapping("/userTest")
	public String userTest() {
		return "test/userTest";
	}

	// 메인페이지 연결
	@GetMapping("/")
	public String index() {
		return "index";
	}

	// 회원가입
	@GetMapping("/registerUser")
	public String register() {
		return "user/registerUser";
	}
	@PostMapping("/registerUser")
	public String register(User user, String birthDay, Model model) {
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {}

		int success = userService.register(user);
		
		System.err.println(success);
		
		if(success == 1) {
			model.addAttribute("registerMsg", "회원가입에 성공 하였습니다.");
			return "index";
		}else {
			model.addAttribute("registerMsg", "회원가입에 실패 하였습니다.");
			return "registerUser";
		}
		
	}

	// 로그인
	@GetMapping("/login")
	public String login() {
		return "user/login";
	}
	
	// 로그인 에러 시 리턴할 메세지
	@GetMapping("/loginError")
	public String loginError(Model model, String error, String username) {
		
		if(error.equals("탈퇴회원")) {
			error = "재가입까지 " + userService.rejoinDate(username) + "일 남았습니다.";
		}
		
		model.addAttribute("msg", error);
		return "user/login";
	}
	
	// 계정 찾기 페이지로 이동
	@GetMapping("/findUser")
	public String findUser() {
		return "user/findUser";
	}
	// 계정 찾기 - ID or PASSWORD
	@PostMapping("/findUser")
	public String findUserID(User user, String birthDay, Model model) {
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {}
		
		if(user.getUserEmail() == null) { // userEmail이 null 이면 아이디 찾기
			user = userService.findUserID(user);
			if(user == null) {
				model.addAttribute("findMsg", "회원이 존재하지 않습니다.");
				return "user/findUser";
			}
			model.addAttribute("userEmail", user.getUserEmail());
			return "user/showUserID";
		}else {
			user = userService.findUserPWD(user);
			if(user == null) {
				model.addAttribute("findMsg", "회원이 존재하지 않습니다.");
				return "user/findUser";
			}
			model.addAttribute("user", user);
			return "user/showUserPWD";
		}
	}
	// 비밀번호 수정 - PASSWORD 찾기 이후 이어지는 메서드
	@PostMapping("/updateUserPWD")
	public String updateUserPWD(User user) {
		userService.updateUserPWD(user);
		return "user/login";
	}

	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		// 유저가 좋아하는 태그 top 5
		List<UserLikeTagDTO> list = userService.userLikeTag(user.getUserEmail());
		
		model.addAttribute("likeTagList", list);
		model.addAttribute("user", user);
		
		return "user/mypage";
	}

	// 회원 수정
	@GetMapping("/updateUser")
	public String updateUser(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		model.addAttribute("user", user);
		
		return "user/updateUser";
	}

	@PostMapping("/updateUser")
	public String updateUser(UserDTO user, Model model) throws IllegalStateException, IOException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) authentication.getPrincipal(); // 현재 접속중인 유저 정보
		
		// 변경할 정보들을 현재접속한 유저 정보에 담아서 서비스로 처리
		u.setUserNickname(user.getUserNickname());
		u.setUserPassword(user.getUserPassword());
		u.setUserPhone(user.getUserPhone());
		// 이미지 변경 로직 추가
		if(!user.getFile().isEmpty()) {
			if(u.getUserImg() != null && !u.getUserImg().equals("http://192.168.10.6:8080/img/user_img/default_user.jpg")) {
				File deleteFile = new File("\\\\192.168.10.6\\vibe\\img\\user_img\\" + new File(u.getUserImg()).getName());
				deleteFile.delete();
			}
			UUID uuid = UUID.randomUUID();
			String fileName = uuid.toString() + "_" + user.getFile().getOriginalFilename();
			File copyFile = new File("\\\\192.168.10.6\\vibe\\img\\user_img\\" + fileName);
			
			user.getFile().transferTo(copyFile); // 업로드한 파일이 지정한 path 위치로 저장
			u.setUserImg("http://192.168.10.6:8080/img/user_img/" + fileName);
		} else {
			u.setUserImg(user.getUserImg());
		}
		
		userService.updateUser(u);
		
		model.addAttribute("user", u);
		
		// 변경된 정보로 session에 다시 담기
		return "user/mypage";
	}

	// 회원 탈퇴
	@GetMapping("/deleteUser")
	public String deleteUser() {
		return "user/deleteUser";
	}
	@PostMapping("/deleteUser")
	public String deleteUser(String userPassword, Model model, HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		HttpSession session = request.getSession(false);
				
		if(userService.deleteUser(user, userPassword)) {
			model.addAttribute("deleteUser", "회원탈퇴 처리되었습니다.");
			
			session.invalidate();
			SecurityContextHolder.getContext().setAuthentication(null);
			return "index";
		}
		model.addAttribute("deleteUser", "비밀번호가 일치하지 않습니다.");
		return "user/deleteUser";
	}

	// 내 프로필 공유하기
	@GetMapping("/shareMyProfile")
	public String shareMyProfile() {
		return "user/shareMyProfile";
	}

	// 로그인 회원 음악 듣기
	@GetMapping("/musicListen")
	public String musicListen(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Object token = session.getAttribute("accessToken");
		model.addAttribute("token", token);
		return "music/musicListen";
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
		} catch (Exception e) {}
		
		u.setUserNickname(userNickname);
		
		return userService.nicknameUpdate(u);
	}
}
