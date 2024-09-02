<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/header.css" />
	<!-- 헤더 영역 -->
	<header>
		<!-- 로고 -->
		<div id="logo">
			<a href="/">
				<img src="/imgs/logo/logoW.png"/>
			</a>
		</div>
		
		<!-- nav1 영역 -->
		<div id="nav1">
			<a href="/searchPlaylist?select=title&search=" id="search">Search</a> 
			<a href="" id="contact">Contact</a>
		</div>
		
		<!-- nav2 영역 -->
		<div id="nav2">
			<sec:authorize access="!isAuthenticated()">
				<a href="/login" class="my">Sign In</a>
				<a href="/registerUser" class="signUp">Sign Up</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="/mypage" class="my">My</a>
				<a href="/logout" class="signUp">Logout</a>
			</sec:authorize>
		</div>
	</header>