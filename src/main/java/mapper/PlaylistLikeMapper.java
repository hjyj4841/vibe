package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.dto.PlaylistLikeDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistLike;

@Mapper
public interface PlaylistLikeMapper {
	
	// 내가 좋아요한 플리 조회
	List<Playlist> likePlaylist(SearchDTO dto);
	
	// 회원이 해당 플레이리스트를 좋아요 표시했는지 조회
	PlaylistLike userLikePlaylistCheck(PlaylistLikeDTO dto);
	// 좋아요
	void userLike(PlaylistLikeDTO dto);
	// 좋아요 취소
	void userUnLike(PlaylistLikeDTO dto);
	// 해당 플리의 좋아요 수 조회
	int showLikeCount(int plCode);
	// 해당 플리 삭제 시 모든 좋아요 삭제
	void deleteAllPlLike(int plCode);
}
