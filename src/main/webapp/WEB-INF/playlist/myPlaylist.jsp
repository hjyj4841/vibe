<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<a href="createPlaylist">플레이리스트 생성</a>
	<table>
		<tr>
			<th>플레이리스트 이미지</th>
			<th>플레이리스트 이름</th>
			<th>공개여부</th>
		</tr>
		<c:forEach items="${playlist }" var="playlist">
			<tr data-code="${playlist.plCode }">
				<td><img src="${playlist.plImg }"></td>
				<td>${playlist.plTitle }</td>
				<td>${playlist.plPublicYn }</td>
			</tr>
		</c:forEach>
	</table>

	<script src="./js/goPlaylistInfo.js"></script>
</body>
</html>