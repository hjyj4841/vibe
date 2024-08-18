package com.master.vibe.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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
	public void register(User user) {
		user.setUserPassword(bcpe.encode(user.getUserPassword()));
		userMapper.register(user);
	}

	// 유저 ID 찾기
	public User findUserID(User user) {
		return userMapper.findUserID(user);
	}

	// 유저 PWD 찾기
	public User findUserPWD(User user) {
		return userMapper.findUserPWD(user);
	}

	// 비밀번호 찾기 후 비밀번호 변경
	public void updateUserPWD(User user) {
		user.setUserPassword(bcpe.encode(user.getPassword()));
		userMapper.updateUserPWD(user);
	}

	// 회원 정보 수정
	public void updateUser(User user) {
		user.setUserPassword(bcpe.encode(user.getUserPassword()));
		userMapper.updateUser(user); // 회원정보 수정
	}

	// 회원탈퇴
	public boolean deleteUser(User user, String userPassword) {
		
		if(bcpe.matches(userPassword, user.getUserPassword())){
			userMapper.deleteUser(user.getUserEmail());
			// 회원탈퇴 user의 playlist를 playlistManager 계정으로 옮기기
			playlistMapper.movePlaylist(user.getUserEmail());
			
			return true;
		}
		return false;
	}

	// 탈퇴한 회원이 재가입 시도시 남은 일수 조회
	public String rejoinDate(String userEmail) {
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

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		return userMapper.emailCheck(username);
	}

}
