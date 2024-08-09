<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이리스트 삭제</title>
</head>
<body>
    <!-- 
    <form action="/deletePlaylist" method="post">
	    <input type="hidden" name="plCode" value="${playlist.plCode}" />
	    <input type="hidden" name="userEmail" value="agrigs9@opensource.org" />
      	<label for="plTitle">플레이리스트 제목:</label>
      	<input type="text" id="plTitle" name="plTitle" required />
      	<button type="submit">플레이리스트 삭제</button>
	</form>
     -->
    
    <form action="/deletePlaylist" method="post">
        <label for="plCode">플레이리스트 코드:</label>
        <input type="text" id="plCode" name="plCode" required />
        <button type="submit">플레이리스트 삭제</button>
    </form>
</body>
</html>
