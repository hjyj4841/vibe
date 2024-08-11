<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이리스트 제목 수정</title>
</head>
<body>
    <h1>플레이리스트 수정</h1>
    <form action="/updatePlaylist" method="post">
        <!-- 플레이리스트 코드와 새로운 제목을 입력받습니다. -->
        <input type="hidden" value="${playlist.plCode }" name="plCode">
        <label for="plTitle">플레이리스트 제목:</label>
        <input type="text" id="plTitle" name="plTitle" value="${playlist.plTitle }" required />
        
        <button type="submit">제목 수정</button>
    </form>
</body>
</html>
