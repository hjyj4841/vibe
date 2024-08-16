<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Playlists by Tag</title>
</head>
<body>

<h1>태그로 플레이리스트 검색</h1>

<form action="${pageContext.request.contextPath}/searchTagRanking" method="get">
    <label for="tagName">태그 입력:</label>
    <input type="text" id="tagName" name="tagName" placeholder="검색할 태그를 입력하세요">
    <button type="submit">검색</button>
</form>

</body>
</html>