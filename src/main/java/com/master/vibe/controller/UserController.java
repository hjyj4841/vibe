package com.master.vibe.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.master.vibe.model.dto.FindUserIDDTO;
import com.master.vibe.model.dto.FindUserPWDDTO;
import com.master.vibe.model.dto.UpdateUserPWDDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.dto.UpdateUserPWDDTO;
import com.master.vibe.model.dto.UserUpdateDTO;
import com.master.vibe.model.vo.User;
import com.master.vibe.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;

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
		} catch (Exception e) {
		}

		userService.register(user);
		return "redirect:/";
	}

	// 로그인
	@GetMapping("/login")
	public String login() {
		return "user/login";
	}

	@PostMapping("login")
	public String login(User user, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		User u = userService.login(user);

		// 아이디 / 비밀번호 조회 실패
		if (u == null) {
			return "user/login_fail_empty_user";
		}
		// 탈퇴한 회원
		if (u.getUserEntYn() == 'Y') {
			model.addAttribute("rejoinDate", userService.rejoinDate(user.getUserEmail()));
			return "user/login_fail_deleteUser";
		}
		// 정상 회원
		session.setAttribute("user", u);
		return "index";
		
	}

	// 아이디 찾기
	@GetMapping("/findUserID")
	public String findUserID() {
		return "user/findUserID";
	}

	@PostMapping("findUserID")
	public String findUserID(FindUserIDDTO dto, Model model) {
		User u = new User();
		u = userService.findUserID(dto);
		model.addAttribute("userEmail", u.getUserEmail());
		return "user/showUserID";

	}

	// 비밀번호 찾기
	@GetMapping("/findUserPWD")
	public String findUserPWD() {
		return "user/findUserPWD";
	}

	@PostMapping("findUserPWD")
	public String findUserPWD(FindUserPWDDTO dto, Model model) {
		User u = new User();
		u = userService.findUserPWD(dto);
		model.addAttribute("user", u);
		return "user/showUserPWD";
	}

	// 비밀번호 수정
	@PostMapping("updateUserPWD")
	public String updateUserPWD(String userEmail, String userPassword) {
		User u = new User();
		u.setUserEmail(userEmail);
		u.setUserPassword(userPassword);
		userService.updateUserPWD(u);
		return "user/login";
	}

	// 로그아웃
	@GetMapping("logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) session.invalidate();
		
		return "index";
	}

	// 마이페이지
	@GetMapping("mypage")
	public String mypage() {
		return "user/mypage";
	}

	// 회원 수정
	@GetMapping("updateUser")
	public String updateUser() {
		return "user/updateUser";
	}

	@PostMapping("updateUser")
	public String updateUser(UserUpdateDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		dto.setUserEmail(user.getUserEmail());
		User u = new User();
		u = userService.updateUser(dto);
		if (u != null) {
			session.setAttribute("user", u);
			return "user/mypage";
		} else {
			return "test/userTest";
		}
	}

	// 회원 탈퇴
	@GetMapping("deleteUser")
	public String deleteUser() {
		return "user/deleteUser";
	}

	@PostMapping("deleteUser")
	public String deleteUser(String userPassword, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (userPassword.equals(user.getUserPassword())) {
			userService.deleteUser(user.getUserEmail());

			if (session.getAttribute("user") != null)
				session.invalidate();
			return "test/userTest";
		}

		return "user/mypage";
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
	


}
