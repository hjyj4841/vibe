<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Playlist</title>
</head>
<body>
    <h1>플레이리스트 생성</h1>

    <form action="/createPlaylist" method="post">
        <input type="hidden" name="user_email" value="agrigs9@opensource.org">
        <label for="pl_title">플레이리스트 제목:</label>
        <input type="text" id="pl_title" name="pl_title" required>
        <button type="submit">플레이리스트 생성</button>
    </form>

</body>
</html>
