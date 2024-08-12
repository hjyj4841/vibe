package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.vo.PlaylistMusic;

@Mapper
public interface PlaylistMusicMapper {
	
	void addMusicToPlaylist(List<PlaylistMusic> list); // 플레이리스트에 곡 추가
	List<String> showMusicList(int plCode); // 플레이리스트의 곡 목록 조회
	// 플레이리스트 곡 삭제
	void deleteMusicFromPlaylist(@Param("plCode") int plCode, @Param("list") List<String> selectedDeleteMusic);
}
