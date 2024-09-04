package com.master.vibe.service;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.GetUserByIdDTO;
import com.master.vibe.model.dto.PlaylistDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.vo.User;

import mapper.PlaylistMapper;
import mapper.UserMapper;

@Service
public class UserService implements UserDetailsService{

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private PlaylistMapper playlistMapper;

	@Autowired
	private PasswordEncoder bcpe;

	// 회원가입
	public int register(User user) {
		user.setUserPassword(bcpe.encode(user.getUserPassword()));
		return userMapper.register(user);
	}
	// 유저 계정 찾기
	public User findUserAccount(User user) {
		// userEmail이 null 이면 아이디 찾기
		if(user.getUserEmail() == null) return userMapper.findUserID(user);
		// userEmail이 null이 아니면 비밀번호 찾기
		return userMapper.findUserPWD(user);
	}
	
	// 비밀번호 찾기 후 비밀번호 변경
	public void updateUserPWD(User user) {
		user.setUserPassword(bcpe.encode(user.getPassword()));
		userMapper.updateUserPWD(user);
	}
	
	// 회원 정보 수정
	public void updateUser(User user) {
		userMapper.updateUser(user); // 회원정보 수정
	}

	// 회원탈퇴
	public boolean deleteUser(User user, String userPassword) {
		if (bcpe.matches(userPassword, user.getUserPassword())) {
			userMapper.deleteUser(user.getUserEmail());
			// 회원탈퇴 user의 playlist를 playlistManager 계정으로 옮기기
			playlistMapper.movePlaylist(user.getUserEmail());
			return true;
		}
		return false;
	}
	
	// 탈퇴한 회원이 재가입 시도시 남은 일수 조회
	public int rejoinDate(String userEmail) {
		return userMapper.rejoinDate(userEmail);
	}

	// 회원이 좋아하는 태그 목록 5개 출력
	public List<UserLikeTagDTO> userLikeTag(String userEmail) {
		List<UserLikeTagDTO> list = userMapper.userLikeTag(userEmail);
		return list != null ? list : new ArrayList<>();
	}

	// 회원가입 시 이메일 중복 체크
	public boolean emailCheck(String userEmail) {
		if(userMapper.emailCheck(userEmail) == null) return true;
		return false;
	}

	// 회원가입 시 닉네임 중복 체크
	public boolean nicknameCheck(String userNickname) {
		if(userMapper.nicknameCheck(userNickname) == null) return true;
		return false;
	}

	// 회원수정 시 닉네임 중복 체크
	public boolean nicknameUpdate(User user) {
		if(userMapper.sameNickname(user) == null) return true;
		return false;
	}

	// 회원정보 수정 시 패스워드 확인
	public boolean passwordCheck(User user, String userPassword) {
		return bcpe.matches(userPassword, user.getUserPassword());
	}
	
	// 공유 용 프로필 페이지
		public User getUserById(String userEmail) {
			User user = userMapper.getUserById(userEmail);
		
			return user;
		}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		return userMapper.emailCheck(username);
	}

}