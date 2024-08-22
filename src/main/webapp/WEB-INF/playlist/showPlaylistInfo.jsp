<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<title>플레이리스트 곡 조회</title>
<style>
td a {
	cursor: pointer;
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<h3>플레이리스트 곡 조회</h3>
	<img src="${playlist.plImg}" style="width: 200px;">
	<a href="myPlaylist">목록</a>
	<h1>${playlist.plTitle }</h1>
	<br>

	<c:if test="${user.userEmail eq playlist.user.userEmail}">
		<a href="addMusic?plCode=${playlist.plCode }">곡 추가</a>
		<a href="deletePlaylist?plCode=${playlist.plCode }">플레이리스트 삭제</a>
		<a href="updatePlaylist?plCode=${playlist.plCode }">플레이리스트 수정</a>
	</c:if>
	
	<h4>태그 : </h4>
	<ul>
		<c:forEach items="${tags}" var="playlistTag">
			${playlistTag.tag}
			<li>#${playlistTag.tag.tagName}</li>
		</c:forEach>
	</ul>	
	
	<form action="deleteMusicFromPlaylist" method="post">
	 <input type="hidden" name="plCode" value="${playlist.plCode}">
	<table>
	<i id="link-copy-icon" class="fa-solid fa-link">링크 공유하기</i>
		<tr>
			<th>선택</th>
			<th>앨범커버</th>
			<th>곡명</th>
			<th>아티스트명</th>
			<th>앨범명</th>

	<h4>태그 :</h4>
	<ul>
		<c:forEach items="${tagList}" var="tag">
			<li>${tag}</li>
		</c:forEach>
	</ul>

	<form action="deleteMusicFromPlaylist" method="post">
		<input type="hidden" name="plCode" value="${playlist.plCode}">
		<table>
			<!-- 링크 공유하기 -->
			<tr>
				<td colspan="5">
					<i id="link-copy-icon" class="fa-solid fa-link" style="cursor:pointer;"> 링크 공유하기</i>
					<span id="copy-message" style="display:none; color: green; margin-left: 10px;">링크가 복사되었습니다!</span>
				</td>
			</tr>
			<tr>
				<th>선택</th>
				<th>앨범커버</th>
				<th>곡명</th>
				<th>아티스트명</th>
				<th>앨범명</th>
			</tr>
			<c:forEach items="${musicList}" var="music" varStatus="status">
				<tr>
					<td><input type="checkbox" name="selectedDeleteMusic"
						value="${music.id}"></td>
					<td><a href="musicDetail?musicId=${music.id}"><img
							src="${music.albumUrl}" style="width: 100px"></a></td>
					<td><a href="musicDetail?musicId=${music.id}">${music.musicTitle}</a></td>
					<td><a href="musicDetail?musicId=${music.id}">${music.artistName}</a></td>
					<td><a href="musicDetail?musicId=${music.id}">${music.albumName}</a></td>
					<td><a href="#" onclick="playMusic('${music.id}')">재생하기</a></td>
				</tr>
			</c:forEach>
		</table>
		<button type="submit">곡 삭제</button>
	</form>

	<!-- 플레이어가 표시될 위치 -->
	<div id="playerContainer" style="margin-top: 20px;">
		<iframe id="main_frame" src="" width="300" height="380"
			frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
	</div>


	<script>

    // 음악을 재생하는 함수
    function playMusic(trackId) {
        const iframe = document.getElementById("main_frame");
        // 자동 재생을 위해 autoplay 파라미터 추가
        iframe.src = "https://open.spotify.com/embed/track/" + trackId + "?autoplay=1";
    }

  
    // 링크 복사 기능 구현
    document.getElementById("link-copy-icon").addEventListener('click', function() {
        const dummy = document.createElement('input');
        const url = window.location.href;
        
        document.body.appendChild(dummy);
        dummy.value = url;
        dummy.select();
        document.execCommand('copy');
        document.body.removeChild(dummy);

        // 링크가 복사되었다는 메시지 표시
        const copyMessage = document.getElementById("copy-message");
        copyMessage.style.display = 'inline';
        setTimeout(function() {
            copyMessage.style.display = 'none';
        }, 2000); // 2초 후 메시지 숨김
    });
</script>
</body>
</html>