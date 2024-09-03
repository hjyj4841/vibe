package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.vo.User;

@Mapper
public interface UserMapper {
	int register(User user); // 회원가입

	void updateUser(User user); // 회원정보 수정

	User sameNickname(User user); // 회원수정 시 중복 닉네임 찾기

	User findUserID(User user); // 회원 ID 찾기

	User findUserPWD(User user); // 회원 비밀번호 찾기

	void updateUserPWD(User user); // 비밀번호 찾은 후 회원 정보 수정

	void deleteUser(String deleteUser); // 탈퇴

	int rejoinDate(String userEmail); // 재가입 시도 시 남은 일 수 조회

	List<UserLikeTagDTO> userLikeTag(String userEmail); // 좋아요한 태그 조회

	void updateSpotifyStatus(@Param("userEmail") String userEmail, @Param("status") String status);

	User emailCheck(String userEmail); // 회원가입 시 이메일 중복 체크
	
	User nicknameCheck(String userNickname); // 회원가입 시 닉네임 중복 체크
	
	User getUserById(String userEmail); // 공유 용 회원 페이지

}
