<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/mypage.css">
<title>my page</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="myLeftBox">
				<div class="myLeftTopBox">	
					<img alt="회원이미지" src="${user.userImg }">
					<div class="myAccInfo">
						<div class="myTagBox">
							<div>
								<p># Rock</p>
								<p># Pop</p>
								<p># Indie</p>
							</div>
							<div>
								<p># Metal</p>
								<p># Hiphop</p>
							</div>
						</div>
						<div>
							<div>
								<c:choose>
									<%-- ascii code : 89 == Y --%>
									<c:when test="${user.userSpotifyYn == 89}">
										spotify 연동
									</c:when>
									<c:otherwise>
										spotify 미연동
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<fmt:formatDate value="${user.userDate}" pattern="yyyy-MM-dd" />
							</div>
						</div>
					</div>
				</div>
				<div class="myLeftBottomBox">
					<div>${user.userNickname }</div>
					<div>${user.userEmail }</div>
					<div>${user.userPhone }</div>
					<div><fmt:formatDate value="${user.userBirth}" pattern="yyyy-MM-dd" /></div>
				</div>
			</div>
			<div class="myRightBox">
			
			</div>
		</div>
		<jsp:include page="../tiles/footer.jsp"></jsp:include>
	</div>


	<%-- 
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
	--%>
</body>
</html>