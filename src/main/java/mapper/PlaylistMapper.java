package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.vo.Playlist;


// PlaylistMapper.java는 플레이리스트를 데이터베이스에 추가하는 addPlaylist 메소드를 정의
// 이 메소드는 Playlist 객체를 매개변수로 받으며, XML에서 정의한 addPlaylist 메소드를 호출합니다.

@Mapper
public interface PlaylistMapper {
	
	List<Playlist> allPlaylist(); // 플리 전체 조회
	void movePlaylist(String userEmail); // 플레이리스트 소유자를 관리자로 변경(회원 탈퇴시)
	void createPlaylist(CreatePlaylistDTO dto); // 플레이리스트 생성
	
//	호출하는 service가 없음
//	List<Playlist> getPlaylistsByTag(@Param("tagCode") String tagCode);
}
