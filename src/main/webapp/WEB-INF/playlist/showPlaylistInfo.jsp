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
/* a 태그 */
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

	<h4>태그 :</h4>
	<ul>
		<c:forEach items="${tagList}" var="tag">
			<li>${tag}</li>
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
			</tr>
			<c:forEach items="${musicList}" var="music">
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
		<iframe id = "main_frame" src=""
			width="300" height="380" frameborder="0" allowtransparency="true"
			allow="encrypted-media"></iframe>
	</div>

	<!-- 플레이리스트 링크 공유 -->
	<script>
		async function onClickCopyLink() {
			const link = window.location.href;
			await navigator.clipboard.writeText(link);
			window.alert('클립보드에 링크가 복사되었습니다.');
		}

		document.getElementById("link-copy-icon").addEventListener("click", onClickCopyLink);

		// 재생하기 버튼 클릭 시 플레이어 출력 및 음악 재생
		function playMusic(trackId) {
			console.log(`Playing track:` + trackId); // trackId가 제대로 전달되는지 확인하기 위한 로그

			const playerContainer = document.getElementById('playerContainer');
			document.getElementById("main_frame").src = "https://open.spotify.com/embed/track/" + trackId;
		}
	</script>
</body>
</html>