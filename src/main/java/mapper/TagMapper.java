package mapper;

import com.master.vibe.model.vo.Tag;
import org.apache.ibatis.annotations.Select;

public interface TagMapper {

    @Select("SELECT tag_code FROM tag WHERE tag_name = #{tagName}")
    Integer getTagCodeByName(String tagName);
}
