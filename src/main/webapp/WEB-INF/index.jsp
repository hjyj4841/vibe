<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Playlist</title>
</head>
<body>
    <h1>Create Playlist</h1>

    <form action="/createPlaylist" method="post">
    	<input type="hidden" name="user_email" value="agrigs9@opensource.org">
        <label for="pl_title">Playlist Title:</label>
        <input type="text" id="pl_title" name="pl_title" required>
        <button type="submit">Create Playlist</button>
    </form>

    <c:if test="${not empty message}">
        <p>${message}</p>
    </c:if>
</body>
</html>
