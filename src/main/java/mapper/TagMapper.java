package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.vo.Tag;

@Mapper
public interface TagMapper {

    Tag findTagByName(@Param("tagName") String tagName);
    
    void insertTag(Tag tag);

    void addTagToPlaylist(@Param("playlistId") int playlistId, @Param("tagCode") int tagCode);
}
