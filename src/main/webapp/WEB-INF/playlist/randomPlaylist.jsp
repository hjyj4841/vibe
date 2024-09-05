<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/imgs/logo/logoB_small.png">
<title>VibeMaster</title>
</head>
<body>
<h1>랜덤 플레이리스트 조회</h1>
<c:forEach var="playlist" items="${randomPlaylist}">
<div>

<img src="${playlist.plImg }">
<span>${playlist.plTitle }</span>
<span>${playlist.user.userEmail }</span>

</div>

</c:forEach>

</body>
</html>