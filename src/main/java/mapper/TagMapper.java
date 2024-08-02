package mapper;

import org.apache.ibatis.annotations.Select;

public interface TagMapper {

	// tag.xml에는 매칭된 쿼리가 없음....
    @Select("SELECT tag_code FROM tag WHERE tag_name = #{tagName}")
    Integer getTagCodeByName(String tagName);
}
