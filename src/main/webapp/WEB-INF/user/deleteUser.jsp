<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원탈퇴</h1>
	<div>정말 탈퇴 할거냐는 메시지</div>
	<form action="deleteUser" method="post">
		비밀번호 입력 : <input type="password" name="userPassword">
		<input type="submit" value="회원 탈퇴">
	</form>
</body>
</html>