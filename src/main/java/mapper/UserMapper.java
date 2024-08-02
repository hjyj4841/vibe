package mapper;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.User;

@Mapper
public interface UserMapper {
	void register(User user);
	User login(User user);
	void deleteUser(String deleteUser);
	String rejoinDate(String userEmail);
}
