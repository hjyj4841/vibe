<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/rankingHome.css" />
</head>
<body>
	<ul>
		<li><a href="/rankingHome?select=like">Like Ranking</a></li>
		<li><a href="rankingHome?select=tag">Tag Ranking</a></li>
		<li><a href="/rankingHome?select=month">Month Ranking</a></li>
		<li><a href="/rankingHome?select=age">Age Ranking</a></li>
		<li><a href="/rankingHome?select=gender">Gender Ranking</a></li>
	</ul>
	${likeranking}
</body>
</html>