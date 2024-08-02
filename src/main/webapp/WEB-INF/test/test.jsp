<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Test Home</h1>
	<ul>
		<li><a href="/test/userTest.jsp">user 기능 테스트</a></li>
		<li>
			<!-- 플레이리스트 생성 -->
	    	<h1>플레이리스트 생성</h1>
	    	<form action="/createPlaylist" method="post">
	     		 <input type="hidden" name="user_email" value="agrigs9@opensource.org" />
	      		<label for="pl_title">플레이리스트 제목:</label>
	      		<input type="text" id="pl_title" name="pl_title" required />
	      		<button type="submit">플레이리스트 생성</button>
	    	</form>
		</li>
		
	</ul>
</body>
</html>