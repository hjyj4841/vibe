package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.Playlist;

@Mapper
public interface PlaylistMapper {
	List<Playlist> allPlayList();
	
}
