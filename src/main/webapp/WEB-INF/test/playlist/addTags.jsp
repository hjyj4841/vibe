<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>태그 추가</title>
</head>
<body>
    <h1>태그 추가</h1>
    <form action="addTags" method="post">
        <input type="hidden" name="playlistId" value="${playlistId}" />
        <label for="tagNames">태그 이름 (쉼표로 구분):</label>
        <input type="text" id="tagNames" name="tagNames" required />
        <button type="submit">태그 추가</button>
    </form>
</body>
</html>
