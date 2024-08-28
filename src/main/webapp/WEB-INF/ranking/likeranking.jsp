<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Ranking</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/likeranking.css" />
</head>
<body>
<jsp:include page="../tiles/header.jsp"></jsp:include>
<jsp:include page="../tiles/rankingHeader.jsp"></jsp:include>
<div class="searchContainer">
		<div class="searchCon">
			<div class="searchBox">
				<form class="mainSearchBox" action="searchPlaylist">
					<select name="select">
						<option value="title">Title</option>
						<option value="tag">Tag</option>
					</select> <input type="text" placeholder="Search Playlist..." name="search" value="${dto.search }">
					<button id="searchPlBtn" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
			<div class="searchListMain">
				<c:forEach items="${searchTag}" var="searchPlaylist">
					<div class="playlistCon">
						<div class="plImgBox">
							<img src="${searchPlaylist.plImg}"
							data-code="${searchPlaylist.plCode}">
						</div>
						<div class="plContentsBox" data-code="${searchPlaylist.plCode}">
							<p class="plTitle">${searchPlaylist.plTitle}</p>
							<p class="plTags">
								<c:forEach items="${searchPlaylist.tagList}" var="tag">
										#${tag.tag.tagName} 
									</c:forEach>
							</p>
							<div class="creatorInfo">
								<img src="${searchPlaylist.user.userImg}">
								<p class="creatorNickname">${searchPlaylist.user.userNickname}</p>
							</div>
						</div>
						<div class="plLikeBox" data-code="${searchPlaylist.plCode}" onclick="clickLike(event)">
							<div>
								<c:choose>
									<c:when test="${not empty searchPlaylist.plLike}">
										<i class="fa-solid fa-heart" id="redHeart"></i>
									</c:when>
									<c:otherwise>
										<i class="fa-regular fa-heart"></i>
									</c:otherwise>
								</c:choose>
								<span>LIKE </span> <span class="likeCount">${searchPlaylist.likeCount }</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	


	



	<div id="rankingList">
		<c:forEach var="playlist" items="${likeranking}">
			<div class="likeBox1">
				<div class="likeBox2">
					<img class="likeImg" src="${playlist.plImg}" alt="Playlist Image" />
					<div class="likeBox3">
						<div class="likeBox4">
							<p class="likeTitle">${playlist.plTitle}</p>
						</div>
						<div class="likeBox5">
							<p class="likeCreator">
								<img src="/imgs/creatorImg/creatorImg5.jpg"> 
								<a>${playlist.user.userNickname}</a>
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




