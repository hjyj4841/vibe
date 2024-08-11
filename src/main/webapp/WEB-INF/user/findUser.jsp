<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>계정 찾기</h1>
	<h1>유저 ID 찾기</h1>
	<form action="findUser" method="post">
		<table>
			<tr>
				<td>생년 월일 :</td>
				<td><input type=date name="birthDay"></td>
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
	<hr>
	<h1>유저 PWD 찾기</h1>
	<form action="findUser" method="post">
		<table>
			<tr>
				<td>이메일 :</td>
				<td><input type=text name="userEmail"></td>
			</tr>

			<tr>
				<td>생년 월일 :</td>
				<td><input type=date name="birthDay"></td>
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