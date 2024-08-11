package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistTag;

@Mapper
public interface PlaylistTagMapper {
	
	List<PlaylistTag> searchTagPlaylist(int code);
	
	List<Integer> searchTag(String search);
	
	//List<PlaylistTag> searchPlaylist(SearchDTO dto); // 플리제목 검색, 태그 검색
	
	//List<Playlist> getPlaylistsByTag(String tagCode);
}
