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
</head>
<body>
	<h1>플레이리스트 곡 조회</h1>
	<c:if test="${user.userEmail eq playlist.user.userEmail}">
		<a href="addMusic?plCode=${playlist.plCode }">곡 추가</a>
		<a href="deletePlaylist?plCode=${playlist.plCode }">플레이리스트 삭제</a>
		<a href="updatePlaylist?plCode=${playlist.plCode }">플레이리스트 수정</a>
	</c:if>
	<table>
	<i id="link-copy-icon" class="fa-solid fa-link">링크 공유하기</i>
		<tr>
			<th>앨범커버</th>
			<th>곡명</th>
			<th>아티스트명</th>
			<th>앨범명</th>

		</tr>
		<c:forEach items="${musicList }" var="music">
			<tr>
				<td><img src="${music.albumUrl }" style="width: 100px"></td>
				<td>${music.musicTitle }</td>
				<td>${music.artistName }</td>
				<td>${music.albumName }</td>
			</tr>
		</c:forEach>
	</table>


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