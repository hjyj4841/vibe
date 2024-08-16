package com.master.vibe.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String register(User user, String birthDay) {
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {}

		userService.register(user);
		return "redirect:/";
	}

	// 로그인
	@GetMapping("/login")
	public String login() {
		return "user/login";
	}
	
	// 로그인 에러
	@PostMapping("/loginError")
	public String loginError(Model model) {
		
		model.addAttribute("msg", "ID 혹은 PASSWORD가 잘못 되었습니다.");
		return "user/login";
	}

	// 탈퇴한 회원 재가입 남은 일수 조회 
	// userService.rejoinDate(user.getUserEmail());
	
	// 계정 찾기 페이지로 이동
	@GetMapping("/findUser")
	public String findUser() {
		return "user/findUser";
	}
	// 계정 찾기
	@PostMapping("findUser")
	public String findUserID(User user, String birthDay, Model model) {
		try {
			user.setUserBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthDay));
		} catch (Exception e) {}
		
		if(user.getUserEmail() == null) { // userEmail이 null 이면 아이디 찾기
			model.addAttribute("userEmail", userService.findUserID(user).getUserEmail());
			return "user/showUserID";
		}else {
			model.addAttribute("user", userService.findUserPWD(user));
			return "user/showUserPWD";
		}
	}
	// 비밀번호 수정
	@PostMapping("updateUserPWD")
	public String updateUserPWD(User user) {
		userService.updateUserPWD(user);
		return "user/login";
	}

	// 마이페이지
	@GetMapping("mypage")
	public String mypage(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		model.addAttribute("user", user);
		
		return "user/mypage";
	}

	// 회원 수정
	@GetMapping("updateUser")
	public String updateUser(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = (User) authentication.getPrincipal();
		
		model.addAttribute("user", user);
		
		return "user/updateUser";
	}

	@PostMapping("updateUser")
	public String updateUser(User user, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) authentication.getPrincipal(); // 현재 접속중인 유저 정보
		
		// 변경할 정보들을 현재접속한 유저 정보에 담아서 서비스로 처리
		u.setUserNickname(user.getUserNickname());
		u.setUserPassword(user.getUserPassword());
		u.setUserPhone(user.getUserPhone());
		// 이미지 변경 로직 추가
		
		userService.updateUser(u);
		
		model.addAttribute("user", u);
		
		// 변경된 정보로 session에 다시 담기
		return "user/mypage";
	}

	// 회원 탈퇴
	@GetMapping("deleteUser")
	public String deleteUser() {
		return "user/deleteUser";
	}

	@PostMapping("deleteUser")
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

	// join
	// 내가 좋아요한 태그
	@GetMapping("userLikeTag")
    public String userLikeTag(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            List<UserLikeTagDTO> list = userService.userLikeTag(user.getUserEmail());
            System.out.println(list.isEmpty());
            model.addAttribute("likeTagList", list);
            return "user/userLikeTag";
        }
        return "user/login";
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
		} catch (CloneNotSupportedException e) {}
		
		u.setUserNickname(userNickname);
		
		return userService.nicknameUpdate(u);
	}
}
