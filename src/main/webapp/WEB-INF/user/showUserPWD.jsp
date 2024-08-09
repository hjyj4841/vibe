<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>확인이 완료되었습니다.</h1>
	<h2>비밀번호 변경을 도와드리겠습니다.</h2>
	<form action="updateUserPWD" method="post">
		<table>
		<tr>
			<td>유저 이메일 입니다.</td>
			<td><input type="text" name=userEmail
				value="${user.getUserEmail()}" readonly></td>
		</tr>
		<tr>
			<td>변경할 비밀번호를 입력해주세요.</td>
			<td><input type="password" name="userPassword"></td>
			<td><button type="submit">변경하기</button></td>
		</tr>
		</table>
	</form>
</body>
</html>