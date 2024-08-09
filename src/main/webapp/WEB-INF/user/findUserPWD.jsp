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
	<h1>유저 PWD 찾기</h1>
	<form action="findUserPWD" method="post">
		<table>
			<tr>
				<td>이메일 :</td>
				<td><input type=text name="userEmail"></td>
			</tr>

			<tr>
				<td>생년 월일 :</td>
				<td><input type=date name="userBirth"></td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td><input type=text name="userPhone"></td>
			</tr>
			<tr>
				<td></td>
				<td><button type="submit">찾기</button></td>
			</tr>
		</table>

	</form>

</body>
</html>