package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistLike;

@Mapper
public interface PlaylistLikeMapper {
	
	// 내가 좋아요한 플리 조회
	List<PlaylistLike> likePlaylist(String userEmail);
}
