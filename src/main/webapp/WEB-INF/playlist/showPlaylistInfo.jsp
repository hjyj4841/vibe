<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h1>${playlist.plTitle }</h1><br>
	
	<c:if test="${user.userEmail eq playlist.user.userEmail}">
		<a href="addMusic?plCode=${playlist.plCode }">곡 추가</a>
		<a href="deletePlaylist?plCode=${playlist.plCode }">플레이리스트 삭제</a>
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
</body>
</html>