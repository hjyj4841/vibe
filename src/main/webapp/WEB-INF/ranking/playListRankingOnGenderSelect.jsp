<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="playListRankingOnGender" method="post">
    <label for="userGender">연령대 선택:</label>
    <select id="userGender" name="userGender">
        <option value="male">남성</option>
        <option value="female">여성</option>
        <option value="nonbinary">게이</option>
    </select>
    <button type="submit">선택</button>
</form>
</body>
</html>