<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>플레이리스트 곡 조회</h1>
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
	
	<table>
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
</body>
</html>