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
	<h1>음악 정보</h1>
	<table>
		<tr>
			<th>이미지</th>
			<th>앨범명</th>
			<th>아티스트명</th>
			<th>음악명</th>
		</tr>
		<c:forEach var="music" items="${musicData }">
			<tr>
				<td><img alt="" src="${music.get(0) }"></td>
				<td>${music.get(1) }</td>
				<td>${music.get(2) }</td>
				<td>${music.get(3) }</td>
			</tr>
		</c:forEach>
	</table>

	<a href="artist">다른 아티스트 찾기</a>
</body>
</html>