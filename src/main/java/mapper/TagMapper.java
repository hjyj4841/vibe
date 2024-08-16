package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.Tag;

@Mapper
public interface TagMapper {

    List<Tag> findTagByName(String tagName);
    void insertTag(Tag tag);
    String findTagNameByCode(int tagCode);
	List<String> findTagsByPlaylistCode(int plCode);
     
}
