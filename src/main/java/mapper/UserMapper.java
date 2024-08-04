package mapper;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.User;

@Mapper
public interface UserMapper {
	void register(User user); // 회원가입
	User login(User user); // 로그인
	void deleteUser(String deleteUser); // 탈퇴
	String rejoinDate(String userEmail); // 재가입 시도 시 남은 일 수 조회
}
