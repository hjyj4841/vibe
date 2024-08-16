package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.vo.PlaylistLike;

@Mapper
public interface PlaylistLikeMapper {
	
	// 내가 좋아요한 플리 조회
	List<PlaylistLike> likePlaylist(String userEmail);
	
	// 좋아요
	void playlistLike(PlaylistLike vo);
	
	// 좋아요테이블에 추가
	PlaylistLike plLike(PlaylistLike vo);
	
	// 좋아요 취소
	int cancle(int code);
	
	// 좋아요 수
	int likeCount(int code);
	
}
