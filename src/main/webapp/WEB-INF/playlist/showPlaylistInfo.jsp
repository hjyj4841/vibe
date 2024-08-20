<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<style>
/* a 태그 */
td a {
	cursor: pointer;
	text-decoration: none;
	color: black;
}
</style>
<style>
/* 임시로 설정해놓은 것 */
/* 플리 제작자 영역*/
.container {
	display: flex;
	align-items: center; /* 세로 방향 중앙 정렬 */
	margin-bottom: 20px;
}
.container img {
	border-radius: 50%;
	height: 30px;
	margin-right: 5px;
}
.container .myNick {
	margin: 0; /* 기본 마진 제거 */
	font-size: 14px;
}
</style>
<script>
	// 플레이리스트 삭제 클릭 시 바로 삭제되는 것 alert으로 방지
	function confirmDelete(event, url) {
		event.preventDefault(); // 링크 클릭 기본 동작 방지
		if (confirm('[${playlist.plTitle}] 플레이리스트를 삭제하시겠습니까?')) {
			window.location.href = url; // 확인 클릭 시 삭제 URL로 이동
		}
	}
</script>
</head>
<body>
	<h3>플레이리스트 곡 조회</h3>
	<img src="http://192.168.10.6:8080/playlistImg/${playlist.plImg}" style="width: 300px;">
	<a href="myPlaylist">목록</a>
	<h1>${playlist.plTitle }</h1>
	
	<c:if test="${user.userEmail eq playlist.user.userEmail}">
		<div class="container">
			<img src="${user.userImg }">
			<p class="myNick">${user.userNickname }</p>
		</div>
		<a href="addMusic?plCode=${playlist.plCode }">곡 추가</a>
		<a href="#" onclick="confirmDelete(event, 'deletePlaylist?plCode=${playlist.plCode }')">플레이리스트 삭제</a>
		<!-- <a href="deletePlaylist?plCode=${playlist.plCode }">플레이리스트 삭제</a> -->
		<a href="updatePlaylist?plCode=${playlist.plCode }">플레이리스트 수정</a>
	</c:if>
	
	<h4>태그 : </h4>
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
		<c:forEach items="${musicList }" var="music">
			<tr>
				<td><input type="checkbox" name="selectedDeleteMusic" value="${music.id}"></td>
				<td>
					<a href="musicDetail?musicId=${music.id}">
						<img src="${music.albumUrl }" style="width: 100px">
					</a>
				</td>
				<td>
					<a href="musicDetail?musicId=${music.id}">
				    	${music.musicTitle }
				    </a>
				</td>
				<td>
					<a href="musicDetail?musicId=${music.id}">
						${music.artistName }
					</a>
				</td>
				<td>
					<a href="musicDetail?musicId=${music.id}">
						${music.albumName }
					</a>	
				</td>
			</tr>
		</c:forEach>
	</table>
	<button type="submit">곡 삭제</button>
	</form>


	<!-- 플레이리스트 링크 공유 -->
	<script>
		async function onClickCopyLink() {
			const link = window.location.href;
			await
			navigator.clipboard.writeText(link);
			window.alert('클립보드에 링크가 복사되었습니다.');
		}

		document.getElementById("link-copy-icon").addEventListener("click",
				onClickCopyLink);
	</script>
</body>
</html>