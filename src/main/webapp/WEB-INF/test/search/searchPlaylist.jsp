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
				<td>${searchPlaylist.plTitle}</td>
				<td><img src="${searchPlaylist.plImg}"></td>
				<td>
				<c:forEach items="${searchPlaylist.tagList}" var="tag">
					#${tag.tag.tagName} 
				</c:forEach>
				</td>
				<td><img src="${searchPlaylist.user.userImg}"></td>
				<td>${searchPlaylist.user.userNickname}</td>	 
			</tr>
		</c:forEach>
	</table>
</body>
</html>