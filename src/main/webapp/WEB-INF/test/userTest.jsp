<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 회원 관리 -->
	<h1>user Test</h1>
    <ul>
      <c:if test="${user == null}">
        <li><a href="login">로그인</a></li>
        <li><a href="registerUser">회원가입</a></li>
      </c:if>
      <c:if test="${user != null}">
        <li><a href="mypage">마이페이지</a></li>
        <li><a href="logout">로그아웃</a></li>
      </c:if>
      <li><a href="artist">api 참고 테스트</a></li>
    </ul>
</body>
</html>