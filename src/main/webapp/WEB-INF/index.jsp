<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/style.css" />
<title>VibeMaster</title>
</head>
<body>
	<jsp:include page="tiles/header.jsp"></jsp:include>
	<!-- 메인 배너 -->
	<section id="mainbanner">
		<div id="mainchant">
			<p id="chant">Vibe that I want to BE</p>
			<p id="maintitle">VIBEMASTER</p>
		</div>

		<nav id="mainnav">
			<sec:authorize access="!isAuthenticated()">
				<a href="login" class="signIn">Sign In</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="mypage" class="signIn">My Page</a>
			</sec:authorize>
			<a href="likeranking" class="ranking">Ranking</a>
		</nav>
		<form class="mainSearchBox" action="searchPlaylist">
			<select name="select">
				<option value="title">Title</option>
				<option value="tag">Tag</option>
			</select> <input type="text" placeholder="Search Playlist..." name="search" />
			<button id="searchPlBtn" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</form>
	</section>

	<!-- DB에 따라 바뀔 부분 -->
	<!-- 리스트 박스 -->
	<div id="listBox">
		<div class="rankButtonBox">
			<div id="fir">1st</div>
			<div class="black" id="sec">2nd</div>
			<div class="black" id="thi">3rd</div>
		</div>
		<div class="listTop">
			<div class="emptyLeft">
				<img src="/imgs/listLogo/2931162_arrow_back_left_direction_move_icon.png">
			</div>
			<div class="listContainer">
				<!-- 랭크 1위 - 상위 리스트 3개만 표출 -->
				<section class="listRank">
					<c:forEach items="${rankTop}" var="searchPlaylist" begin="0" end="0">
						<img src="${searchPlaylist.plImg}"
							data-code="${searchPlaylist.plCode}">
						<div class="listRankDesc">
							<img src="${searchPlaylist.plImg}"
								data-code="${searchPlaylist.plCode}">
							<div class="rankTag">
								<c:forEach items="${searchPlaylist.tagList}" var="tag">
									<c:if test="${empty tag.tag.tagName}">
										<div style="opacity: 0">&nbsp</div>
									</c:if>
									<c:if test="${not empty tag.tag.tagName}">
										#${tag.tag.tagName}
									</c:if>
								</c:forEach>
							</div>
							<div class="listRankText">
								<p>${searchPlaylist.plTitle}</p>
								<p>${searchPlaylist.user.userNickname}</p>
							</div>
						</div>
					</c:forEach>
				</section>

				<!-- 랭크 2위 -->
				<section class="listRank">
					<c:forEach items="${rankTop}" var="searchPlaylist" begin="1" end="1">
						<img src="${searchPlaylist.plImg}"
							data-code="${searchPlaylist.plCode}">
						<div class="listRankDesc">
							<img src="${searchPlaylist.plImg}"
								data-code="${searchPlaylist.plCode}">
							<div class="rankTag">
								<c:forEach items="${searchPlaylist.tagList}" var="tag">
									<c:if test="${empty tag.tag.tagName}">
										<div style="opacity: 0">&nbsp</div>
									</c:if>
									<c:if test="${not empty tag.tag.tagName}">
										#${tag.tag.tagName}
									</c:if>
								</c:forEach>
							</div>
							<div class="listRankText">
								<p>${searchPlaylist.plTitle}</p>
								<p>${searchPlaylist.user.userNickname}</p>
							</div>
						</div>
					</c:forEach>
				</section>

				<!-- 랭크 3위 -->
				<section class="listRank">
					<c:forEach items="${rankTop}" var="searchPlaylist" begin="2" end="2">
						<img src="${searchPlaylist.plImg}"
							data-code="${searchPlaylist.plCode}">
						<div class="listRankDesc">
							<img src="${searchPlaylist.plImg}"
								data-code="${searchPlaylist.plCode}">
							<div class="rankTag">
								<c:forEach items="${searchPlaylist.tagList}" var="tag">
									<c:if test="${empty tag.tag.tagName}">
										<div style="opacity: 0">&nbsp</div>
									</c:if>
									<c:if test="${not empty tag.tag.tagName}">
										#${tag.tag.tagName}
									</c:if>
								</c:forEach>
							</div>
							<div class="listRankText">
								<p>${searchPlaylist.plTitle}</p>
								<p>${searchPlaylist.user.userNickname}</p>
							</div>
						</div>
					</c:forEach>
				</section>
			</div>
			<div class="emptyRight">
				<img src="/imgs/listLogo/2931159_arrow_forward_right_move_navigation_icon.png">
			</div>
		</div>
	</div>
	<script src="./js/scroll.js"></script>
	<script src="./js/main.js"></script>
</body>
</html>
