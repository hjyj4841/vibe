<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/ef885bd654.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>PlayList Title</th>
			<th>PlayList</th>
			<th>#HashTag</th>
			<th>User</th>
			<th>UserNickName</th>
			<th>좋아요</th>
			<th>count</th>
		</tr>
		<c:forEach items="${searchTag}" var="searchPlaylist">
			<tr>
				<td>
					<a href="/showPlaylistInfo?plCode=${searchPlaylist.plCode}">
						${searchPlaylist.plTitle}
					</a>
				</td>
				<td><img src="${searchPlaylist.plImg}"></td>
				<td>
				<c:forEach items="${searchPlaylist.tagList}" var="tag">
					#${tag.tag.tagName} 
				</c:forEach>
				</td>
				<td><img src="${searchPlaylist.user.userImg}"></td>
				<td>${searchPlaylist.user.userNickname}</td>
				<c:if test="${empty likeCheck }">
					<td id="like"><i class="fa-regular fa-heart"></i></td>
				</c:if>
				<c:if test="${not empty likeCheck }">
					<td id="unlike"><i class="fa-solid fa-heart"></i></td>
				</c:if>
				<td><div class="like"></div></td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 
	<script>
		$("#like").click(()=>{
			$.ajax({
				type: "post",
				url: "/like",
				data: {
					code : ${playlistLike.plCode}
				},
				success:function(){
					location.reload();
				}
			})
		});
	</script>
	 -->
</body>
</html>















