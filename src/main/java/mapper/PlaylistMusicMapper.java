package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistMusic;

@Mapper
public interface PlaylistMusicMapper {
	
	void addPlaylist(List<PlaylistMusic> list); // 플레이리스트 곡추가

}
