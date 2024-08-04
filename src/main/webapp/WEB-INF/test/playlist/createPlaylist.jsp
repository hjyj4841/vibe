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
    		<!-- 임시로 넣어둔 유저, 추후 로그이한 유저 정보로 수정 예정 -->
     		<input type="hidden" name="userEmail" value="agrigs9@opensource.org" />
      		<label for="plTitle">플레이리스트 제목:</label>
      		<input type="text" id="plTitle" name="plTitle" required />
      		<button type="submit">플레이리스트 생성</button>
    	</form>
</body>
</html>