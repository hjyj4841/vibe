<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<!-- 플레이리스트 생성 -->
    	<h1>플레이리스트 생성</h1>
    	<form action="createPlaylist" method="post">
      		<label for="plTitle">플레이리스트 제목:</label>
      		<input type="text" id="plTitle" name="plTitle" required />
      		<button type="submit">플레이리스트 생성</button>
    	</form>
</body>
</html>