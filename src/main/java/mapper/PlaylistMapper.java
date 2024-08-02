package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.Playlist;

// PlaylistMapper.java는 플레이리스트를 데이터베이스에 추가하는 addPlaylist 메소드를 정의
// 이 메소드는 Playlist 객체를 매개변수로 받으며, XML에서 정의한 addPlaylist 메소드를 호출합니다.

@Mapper
public interface PlaylistMapper {
	void addPlaylist(Playlist playlist);
	void movePlaylist(String userEmail);
	
    //@Insert("INSERT INTO playlist (pl_title, user_email) VALUES (#{plTitle}, #{userEmail})")
    void insertPlaylist(Playlist playlist);

	List<Playlist> allPlaylist();
	List<Playlist> allPlayList();
}
