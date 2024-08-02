<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="register" method="post">
		<div><input type="text" name="userEmail" placeholder="Email"></div>
		<div><input type="password" name="userPassword" placeholder="Password"></div>
		<div><input type="text" name="userNickname" placeholder="Nickname"></div>
		<div>
			<h3>성별 선택</h3>
			<label><input type="radio" name="userGender" value="male"> 남자</label>
			<label><input type="radio" name="userGender" value="female"> 여자</label>
			<label><input type="radio" name="userGender" value="nonbinary"> 논바이너리</label>
		</div>
		<div>
			생년월일 : <input type="date" name="birthDay">
		</div>
		<div><input type="text" name="userPhone" placeholder="PhoneNum : 000-0000-0000"></div>
		<input type="submit" value="회원가입">
	</form>
</body>
</html>