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

<c:if test="${not empty searchTagRanking}">
    <c:forEach var="playlist" items="${searchTagRanking}">
        <div>
            <img src="${playlist.plImg}" alt="Playlist Image" style="width:150px;height:150px;">
            <h2>${playlist.plTitle}</h2>
            <p>작성자: ${playlist.user.userNickname}</p>
            <p>좋아요 수: ${playlist.likeCount}</p>
        </div>
        <hr>
    </c:forEach>
</c:if>

<c:if test="${empty searchTagRanking}">
    <p>검색된 결과가 없습니다.</p>
</c:if>

<a href="${pageContext.request.contextPath}/searchTag">다시 검색</a>

</body>
</html>