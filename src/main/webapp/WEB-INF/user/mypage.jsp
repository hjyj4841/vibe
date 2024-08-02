<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마이페이지</h1>
	<table>
		<tr>
			<td>Image : </td>
			<td><img alt="회원이미지" src="${user.userImg }"></td>
		</tr>
		<tr>
			<td>E-mail : </td>
			<td>${user.userEmail }</td>
		</tr>
		<tr>
			<td>Nickname : </td>
			<td>${user.userNickname }</td>
		</tr>
		<tr>
			<td>생일 : </td>
			<td><fmt:formatDate value="${user.userBirth}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td>가입일 : </td>
			<td><fmt:formatDate value="${user.userDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td>스포티파이 연동 유무 : </td>
			<td>
			<c:choose>
				<c:when test="${user.userSpotifyYn == 89}"> <!-- ascii code : 89 == Y -->
					연동
				</c:when>
				<c:otherwise>
					미연동
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td>전화번호 : </td>
			<td>${user.userPhone }</td>
		</tr>
	</table>
	<a href="deleteUser">회원탈퇴</a>
</body>
</html>