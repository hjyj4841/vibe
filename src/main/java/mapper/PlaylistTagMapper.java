package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;

@Mapper
public interface PlaylistTagMapper {
	// 전체 검색, 태그 검색
	List<Playlist> search(SearchDTO dto);
	List<Playlist> getPlayLikesByTagLikeCount(String tagCode);
}
