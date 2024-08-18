<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="playListRankingOnAgeGroup" method="post">
    <label for="ageGroup">연령대 선택:</label>
    <select id="ageGroup" name="ageGroup">
        <option value="10대">10대</option>
        <option value="20대">20대</option>
        <option value="30대">30대</option>
        <option value="40대">40대</option>
        <option value="50대">50대</option>
        <option value="기타">기타</option>
    </select>
    <button type="submit">선택</button>
</form>
</body>
</html>