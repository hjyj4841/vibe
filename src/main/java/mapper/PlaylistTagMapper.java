package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.Tag;

@Mapper
public interface PlaylistTagMapper {
	
	List<PlaylistTag> searchTagPlaylist(int plCode);
	
	List<Integer> searchTag(String search);
	
	 // 태그를 DB에 삽입
    void insertTag(Tag tag);

    // 플레이리스트 태그를 DB에 삽입
    void insertPlaylistTag(int plCode, int tagCode);
    
    // 플레이리스트 태그를 플리태그에서 삭제
    void deletePlaylistTag(int plCode, int tagCode);

    // 태그 이름으로 태그 조회
    Tag selectTagByName(String tagName);

}