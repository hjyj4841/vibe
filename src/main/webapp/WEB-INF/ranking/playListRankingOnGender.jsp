<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>

	<h1>검색 결과</h1>
	<c:choose>
			<c:when test="${userGender == 'male'}"><h2>남성</h2></c:when>
			<c:when test="${userGender == 'female'}"><h2>여성</h2></c:when>
			<c:when test="${userGender == 'nonbinary'}"><h2>게이</h2></c:when>
			<c:otherwise>알 수 없음</c:otherwise>
		</c:choose>
	<c:forEach var="playlist" items="${playListRankingOnGender}">
		<div>
			<img src="${playlist.plImg}" alt="Playlist Image"
				style="width: 150px; height: 150px;">
			<h2>${playlist.plTitle}</h2>
			<p>작성자: ${playlist.user.userNickname}</p>
			<c:choose>
			<c:when test="${userGender == 'male'}"><p>남성의 좋아요 수: ${playlist.likeCount}</p></c:when>
			<c:when test="${userGender == 'female'}"><p>여성의 좋아요 수: ${playlist.likeCount}</p></c:when>
			<c:when test="${userGender == 'nonbinary'}"><p>게이의 좋아요 수: ${playlist.likeCount}</p></c:when>
			<c:otherwise>알 수 없음</c:otherwise>
		</c:choose>
			
		</div>
		<hr>
	</c:forEach>
</body>