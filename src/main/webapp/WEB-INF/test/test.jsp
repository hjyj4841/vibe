<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Test Home</h1>
	<ul>
		<li><a href="userTest">user 관련</a></li>
		<li><a href="createPlaylist">플레이리스트 생성</a></li>
		<li><a href="addMusic">플레이리스트 곡 추가</a></li>
		<li><a href="searchHome">플레이리스트 검색</a></li>
		<li><a href="playlistMusic">플레이리스트 곡 조회</a></li>
		<li>
			<form action="showPlaylistMusic">
				<input type="text" name="plCode" placeholder="test_code = 1">
				<button type="submit">검색</button>
			</form>
		</li>
	</ul>
	
</body>
</html>