package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.vo.MusicPaging;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistMusic;

@Mapper
public interface PlaylistMusicMapper {
	
	void addMusicToPlaylist(List<PlaylistMusic> list); // 플레이리스트에 곡 추가
	
	List<String> showMusicList(MusicPaging paging); // 플레이리스트의 곡 목록 조회

	// 플레이리스트 곡 삭제
	void deleteMusicFromPlaylist(@Param("plCode") int plCode, @Param("list") List<String> selectedDeleteMusic);
	
	// 플레이리스트 곡 추가 시 중복 체크
	List<String> getExistingMusicIdInPlaylist(Map<String, Object> params);
}
