package mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlaylistMapper {
	void movePlaylist(String userEmail);
}
