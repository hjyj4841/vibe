<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/header.css" />
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 영역 -->
	<header>
		<!-- 로고 -->
		<div id="logo">
			<a href="/">
				<img src="/imgs/logo/logoW.png" alt="" />
			</a>
		</div>
		
		<!-- nav1 영역 -->
		<div id="nav1">
			<a href="" id="search">Search</a> 
			<a href="" id="contact">Contact</a>
		</div>
		
		<!-- nav2 영역 -->
		<div id="nav2">
			<c:if test="${user == null }">
				<a href="login" class="my">Sign In</a>
				<a href="registerUser" class="signUp">Sign Up</a>
			</c:if>
			<c:if test="${user != null }">
				<a href="mypage" class="my">My</a>
				<a href="logout" class="signUp">Logout</a>
			</c:if>
		</div>
	</header>
</body>
</html>