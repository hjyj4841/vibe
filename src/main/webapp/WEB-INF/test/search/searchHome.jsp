<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/ef885bd654.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- 플리 검색 -->
	<h3>플리 검색</h3>
	<form action="searchPlaylist">
		<select name="select">
			<option value="title">제목 검색</option>
			<option value="tag">태그 검색</option>
		</select> 
		플리 : <input type="text" name="search"> 
		<input type="submit" value="검색">
	</form>

	<br>
	<br>
	<br>

	<table border="1">
		<tr>
			<th>plCode</th>
			<th>플리 제목</th>
			<th>플리</th>
			<th>Date</th>
			<th>공유 여부</th>
			<th>좋아요</th>
			<th>count</th>
		</tr>
		<c:forEach items="${allPlaylist}" var="playlist">
			<tr>
				<td>${playlist.plCode }</td>
				<td>${playlist.plTitle }</td>
				<td><img src="${playlist.plImg }"></td>
				<td>${playlist.plDate }</td>
				<td>${playlist.plPublicYn }</td>
				<c:if test="${empty likeCheck }">
					<td class="like" data-code="${playlist.plCode }"><i class="fa-regular fa-heart"></i></td>
				</c:if>
				<c:if test="${not empty likeCheck }">
					<td class="unlike"><i class="fa-solid fa-heart"></i></td>
				</c:if>
				<td><div class="likeCount"></div></td>
			</tr>
		</c:forEach>
	</table>
	<script>
	const likes = document.querySelectorAll(".like");
	
	likes.forEach(like => {
		like.addEventListener('click', function(){
			const code = like.getAttribute("data-code");
			alert(code);
			$.ajax({
				type: "post",
				url: "/like",
				data: {
					code : code
				},
				success:function(){
					location.reload()
					alert("좋아요");
				},
				error:function(){
					alert("다시");
				}
			})
		})
	});
	/*
		$("#like").click(()=>{
			$.ajax({
				type: "post",
				url: "/like",
				data: {
					code : ${playlist.plCode}
				},
				success:function(){
					alert("좋아요");
				},
				error:function(){
					alert("다시");
				}
			})
		}); */
	</script>
</body>
</html>