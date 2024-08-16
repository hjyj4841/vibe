package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.Tag;

@Mapper
public interface PlaylistTagMapper {
	
	List<PlaylistTag> searchTagPlaylist(int plCode);
	
//	service에서 호출은 하나 호출하는 controller가 없음
//	List<Playlist> getPlaylistsByTag(String tagCode);
	List<Integer> searchTag(String search);
	
	//List<PlaylistTag> searchPlaylist(SearchDTO dto); // 플리제목 검색, 태그 검색
	
	//List<Playlist> getPlaylistsByTag(String tagCode);
	
	 // 태그를 DB에 삽입
    void insertTag(Tag tag);

    // 플레이리스트 태그를 DB에 삽입
    void insertPlaylistTag(int plCode, int tagCode);

    // 태그 이름으로 태그 조회
    Tag selectTagByName(String tagName);

}