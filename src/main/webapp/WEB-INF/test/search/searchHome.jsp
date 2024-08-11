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
		</tr>
		<c:forEach items="${allPlaylist}" var="playlist">
			<tr>
				<td>${playlist.plCode }</td>
				<td>${playlist.plTitle }</td>
				<td><img src="${playlist.plImg }"></td>
				<td>${playlist.plDate }</td>
				<td>${playlist.plPublicYn }</td>
				<td>
					<div class="like">
						<i class="fa-regular fa-heart"></i>
					</div>
				</td>
			</tr>
		</c:forEach>
	</table>

	<script>
		// post방식으로
		// /like
		// 회원 이메일, 플레이리스트 코드, 좋아요 날짜 보내서 좋아요 테이블에 저장
		// 돌아와서 "#like"의 <i class="fa-regular fa-heart"></i> 숨김 후 <i class="fa-solid fa-heart"></i> 추가
		
		$(".like").click((e)=>{
			$.ajax({
				type: "get",
				url: "/like",
				success: function(result){
					console.log(result);
					$(e.target).text(result);
				}
			})
		});
	</script>
</body>
</html>