<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>PlayList Title</th>
			<th>PlayList</th>
			<th>#HashTag</th>
			<th>User</th>
			<th>UserNickName</th>
		</tr>
		<c:forEach items="${searchTag}" var="searchPlaylist">
			<tr>
				<td>${searchPlaylist.playlist.plTitle}</td>
				<td><img src="${searchPlaylist.playlist.plImg}"></td>
				<td>${searchPlaylist.tag.tagName}</td>
				<td><img src="${searchPlaylist.playlist.user.userImg}"></td>
				<td>${searchPlaylist.playlist.user.userNickname}</td>	 
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>