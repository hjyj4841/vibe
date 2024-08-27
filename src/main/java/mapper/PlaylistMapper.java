package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.master.vibe.model.dto.CreatePlaylistDTO;
import com.master.vibe.model.dto.SearchDTO;
import com.master.vibe.model.vo.Paging;
import com.master.vibe.model.dto.UpdatePlaylistDTO;
import com.master.vibe.model.vo.Playlist;
import com.master.vibe.model.vo.PlaylistTag;


// PlaylistMapper.java는 플레이리스트를 데이터베이스에 추가하는 addPlaylist 메소드를 정의
// 이 메소드는 Playlist 객체를 매개변수로 받으며, XML에서 정의한 addPlaylist 메소드를 호출합니다.

@Mapper
public interface PlaylistMapper {
	
	List<Playlist> allPlaylist(SearchDTO dto); // 플리 전체 조회
	
	List<Playlist> rankPlaylist(SearchDTO dto); // 검색한 플리 좋아요 TOP 5

	List<Integer> searchTag(String search);
	List<PlaylistTag> searchTagPlayList(int code);
	
	void movePlaylist(String userEmail); // 플레이리스트 소유자를 관리자로 변경(회원 탈퇴시)
	
	void createPlaylist(CreatePlaylistDTO dto); // 플레이리스트 생성
	
	List<Playlist> myPlaylist(SearchDTO dto); // 회원 본인의 플레이리스트 조회
	
	Playlist selectPlaylistByPlCode(int plCode); // plCode로 플레이리스트 조회

    // @Select("SELECT LAST_INSERT_ID()")
    // int getLastInsertedId(); // 최근 삽입된 플레이리스트의 ID를 가져옴

	void deletePlaylistTags(int plCode); // 플레이리스트 태그 삭제
    void deletePlaylist(int plCode); // 플레이리스트 삭제
        
//    void updatePlaylist(UpdatePlaylistDTO dto); // 플레이리스트 수정
    void updatePlaylist(Playlist playlist); // 플레이리스트 수정
    
    //void updatePlaylistTitle(Playlist playlist); // 플레이리스트 제목 수정
    
    List<Playlist> likerankingPlaylist(); // 랭킹 : 좋아요순
    
	void deletePlaylistMusic(int plCode);
	
	List<String> findTagsByPlaylistCode(int plCode);

    List<Playlist> randomPlaylist(String userEmail); // 플레이리스트 랜덤 조회 
    
    List<Playlist> searchTagRanking(String tagName); // 검색 태그별 랭킹 조회 
    
    List<Playlist> playListRankingOnMonth(); // 한달 동안의 플레이리스트 좋아요 랭킹 조회
    
    Playlist likeRankByUserEmail(String userEmail); // 특정유저의 플레이리스트 좋아요가 가장 많은 플레이리스트
    
    List<Playlist> playListRankingOnAgeGroup(SearchDTO dto); // 연령대별 좋아요 랭킹
    
    List<Playlist> playListRankingOnGender(SearchDTO dto); // 성별 별 좋아요 랭킹
    
}
