package com.master.vibe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.vo.User;

import mapper.PlaylistMapper;
import mapper.UserMapper;

@Service
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PlaylistMapper playlistMapper;
	
	// 회원가입
	public void register(User user) {
		userMapper.register(user);
	}
	
	// 로그인
	public User login(User user) {
		User u = userMapper.login(user);
		
		System.err.println("service : " + u);
		
		// 가입한 회원이 아니라면
		if(u == null) return null;
			
		return u; // 계정이 있는 회원이라면
	}
	
	// 회원탈퇴
	public void deleteUser(String userEmail) {
		userMapper.deleteUser(userEmail);
		
		// 회원탈퇴 user의 playlist를 playlistManager 계정으로 옮기기
		playlistMapper.movePlaylist(userEmail);
	}
	
	// 탈퇴 회원이 재가입 시도시 남은 일수 조회
	public String rejoinDate(String userEmail) {
		return userMapper.rejoinDate(userEmail);
	}
	
}
