package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistMusic;

@Mapper
public interface PlaylistMusicMapper {
	
	void addMusicInPlaylist(List<PlaylistMusic> list); // 플레이리스트에 곡 추가

}
