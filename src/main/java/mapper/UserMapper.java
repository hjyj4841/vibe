package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.dto.FindUserIDDTO;
import com.master.vibe.model.dto.FindUserPWDDTO;
import com.master.vibe.model.dto.UserLikeTagDTO;
import com.master.vibe.model.dto.UserUpdateDTO;
import com.master.vibe.model.vo.User;

@Mapper
public interface UserMapper {
	void register(User user); // 회원가입

	User login(User user); // 로그인

	void updateUser(UserUpdateDTO dto); // 회원정보 수정

	User sameNickname(UserUpdateDTO dto); // 중복 닉네임 찾기

	User findUserID(FindUserIDDTO dto); // 회원 ID 찾기

	User findUserPWD(FindUserPWDDTO dto); // 회원 비밀번호 찾기

	void updateUserPWD(User user); // 비밀번호 찾은 후 회원 정보 수정

	void deleteUser(String deleteUser); // 탈퇴

	String rejoinDate(String userEmail); // 재가입 시도 시 남은 일 수 조회

	List<UserLikeTagDTO> userLikeTag(String userEmail); // 좋아요한 태그 조회

	void updateSpotifyStatus(@Param("userEmail") String userEmail, @Param("status") String status);

}
