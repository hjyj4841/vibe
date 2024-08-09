<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이리스트 제목 수정</title>
</head>
<body>
    <h1>플레이리스트 제목 수정</h1>
    <form action="/updatePlaylist" method="post">
        <!-- 플레이리스트 코드와 새로운 제목을 입력받습니다. -->
        <label for="plCode">플레이리스트 코드:</label>
        <input type="text" id="plCode" name="plCode" required />
        
        <label for="newPlTitle">새 제목:</label>
        <input type="text" id="newPlTitle" name="newPlTitle" required />
        
        <button type="submit">제목 수정</button>
    </form>
</body>
</html>
