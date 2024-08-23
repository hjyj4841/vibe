<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Ranking</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="./css/likeranking.css" />
</head>
<body>
	<div class="likeHead">Like Ranking</div>
	<div id="rankingList">
		<c:forEach var="playlist" items="${likeranking}">
			<div class="likeBox1">
				<div class="likeBox2">
					<img class="likeImg" src="${playlist.plImg}" alt="Playlist Image" />
					<div class="likeBox3">
						<div class="likeBox4">
							<p class="likeTitle">${playlist.plTitle}</p>
							<p class="likeTag">
								#여름에바 #여름싸베바 #이건사계절이 #아니야
								<c:forEach items="${searchPlaylist.tagList}" var="tag">
											#${tag.tag.tagName} 
								</c:forEach>
							</p>
						</div>
						<div class="likeBox5">
							<p class="likeCreator">
								<img src="/imgs/creatorImg/creatorImg5.jpg"> <a>${playlist.user.userNickname}</a>
							</p>
						</div>
					</div>
				</div>
			</div>

		</c:forEach>
	</div>
</body>
<a href="" class="top">TOP</a>
</html>




