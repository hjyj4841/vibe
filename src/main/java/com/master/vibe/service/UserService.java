package com.master.vibe.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.master.vibe.model.dto.FindUserIDDTO;
import com.master.vibe.model.dto.FindUserPWDDTO;
import com.master.vibe.model.dto.UpdateUserPWDDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.dto.UserUpdateDTO;
import com.master.vibe.model.vo.User;

import mapper.PlaylistMapper;
import mapper.UserMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


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
		// 가입한 회원이 아니라면
		if (u == null)
			return null;

		return u; // 계정이 있는 회원이라면
	}

	// 유저 ID 찾기
	public User findUserID(FindUserIDDTO dto) {
		User u = userMapper.findUserID(dto);
		return u;
	}

	// 유저 PWD 찾기
	public User findUserPWD(FindUserPWDDTO dto) {
		User u = userMapper.findUserPWD(dto);
		System.out.println(u);
		return u;
	}

	// 비밀번호 찾기 후 비밀번호 변경

	public void updateUserPWD(User user) {
		userMapper.updateUserPWD(user);

	}

	// 회원 정보 수정
	public User updateUser(UserUpdateDTO dto) {
		if (userMapper.sameNickname(dto) == null) {
			;
			userMapper.updateUser(dto);
			User user = new User();
			user.setUserEmail(dto.getUserEmail());
			user.setUserPassword(dto.getUserPassword());
			return userMapper.login(user);
		} else {
			return null;
		}
	}

	// 회원탈퇴
	public void deleteUser(String userEmail) {
		userMapper.deleteUser(userEmail);
		// 회원탈퇴 user의 playlist를 playlistManager 계정으로 옮기기
		playlistMapper.movePlaylist(userEmail);
	}

	// 탈퇴한 회원이 재가입 시도시 남은 일수 조회
	public String rejoinDate(String userEmail) {
		return userMapper.rejoinDate(userEmail);
	}

	public List<UserLikeTagDTO> userLikeTag(String userEmail) {
        List<UserLikeTagDTO> list = userMapper.userLikeTag(userEmail);
        return list != null ? list : new ArrayList<>();
    }
	
//	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
//
//
//    public List<UserLikeTagDTO> userLikeTag(String userEmail) {
//        List<UserLikeTagDTO> tags = userMapper.userLikeTag(userEmail);
//        logger.debug("UserLikeTagDTO: {}", tags);
//        return tags;
//    }

}
