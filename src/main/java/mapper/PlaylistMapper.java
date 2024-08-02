package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;

@Mapper
public interface PlaylistMapper {
	List<Playlist> getPlaylistsByTag(@Param("tagCode") String tagCode);
}































