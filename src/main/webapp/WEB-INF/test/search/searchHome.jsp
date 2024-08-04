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
	<!-- 플리 검색 -->
    <h3>플리 검색</h3>
	<form action="searchPlaylist">
	<select name="select">
		<option value="title">제목 검색</option>
		<option value="tag">태그 검색</option>
	</select>
		플리 : <input type="text" name="search">
		<input type="submit" value="검색">
	</form>
	
	<br><br><br>
	
	<table border="1">
		<tr>
			<th>plCode</th>
			<th>플리 제목</th>
			<th>플리</th>
			<th>Date</th>
			<th>공유 여부</th>
		</tr>
		<c:forEach items="${allPlaylist}" var="playlist">
			<tr>
				<td>${playlist.plCode }</td>
				<td>${playlist.plTitle }</td>
				<td><img src="${playlist.plImg }"></td>
				<td>${playlist.plDate }</td>
				<td>${playlist.plPublicYn }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>