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
	<h1>회원 정보 수정</h1>
	<form action="updateUser" method="post">
		<table>
			<tr>
				<td>비밀번호 수정 :</td>
				<td><input type=password name="userPassword"
					value="${user.userPassword }"></td>
			</tr>
			<tr>
				<td>닉네임 수정 :</td>
				<td><input type=text name="userNickname"
					value="${user.userNickname }"></td>
			</tr>
			<tr>
				<td>전화번호 수정 :</td>
				<td><input type=text name="userPhone"
					value="${user.userPhone }"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button type="submit">수정하기</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>