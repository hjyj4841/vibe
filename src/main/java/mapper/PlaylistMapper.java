// PlaylistMapper.java
package mapper;

import com.master.vibe.model.vo.Playlist;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlaylistMapper {

    @Insert("INSERT INTO playlist (pl_title, user_email) VALUES (#{plTitle}, #{userEmail})")
    int insertPlaylist(Playlist playlist);
}
