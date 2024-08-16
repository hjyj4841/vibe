<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<!-- 랭킹화면 후에 jstl 처리로 간결해질 예정... -->
	<div class="rankContainer">
		<!-- 랭크 1 -->
		<div class="rankBox">
			<h1>PlayList Ranking Sort By Popular</h1>
			<div class="playlistCon">
				<img src="/imgs/playlistimg/list8.jpg">
				<div class="plContentsBox">
					<p class="plTitle">아무것도 안하기</p>
					<p class="plTags">#아무 #것도 #안하기</p>
					<div class="creatorInfo">
						<img src="/imgs/creatorImg/creatorImg1.jpg">
						<p class="creatorNickname">sehooninseoul</p>
					</div>
				</div>
				<div class="plLikeBox">
					<div>
						<i class="fa-regular fa-heart"></i>
						<span>LIKE 2,132</span>
					</div>
				</div>
			</div>
			<!-- 랭크 2 -->
			<div class="playlistCon">
				<img src="/imgs/playlistimg/list4.jpg">
				<div class="plContentsBox">
					<p class="plTitle">듣는 순간 하트시그널 출연자로 기억조작</p>
					<p class="plTags">#하트 #시그널 #기억조작</p>
					<div class="creatorInfo">
						<img src="/imgs/creatorImg/creatorImg2.jpg">
						<p class="creatorNickname">리플레이LEEPLAY</p>
					</div>
				</div>
				<div class="plLikeBox">
					<div>
						<i class="fa-regular fa-heart"></i>
						<span>LIKE 1,852</span>
					</div>
				</div>
			</div>
			<!-- 랭크 3 -->
			<div class="playlistCon">
				<img src="/imgs/playlistimg/list5.jpg">
				<div class="plContentsBox">
					<p class="plTitle">내 꿈은 여름 락스타</p>
					<p class="plTags">#여름밴드플레이리스트 #밴드플레이리스트 #여름플레이리스트</p>
					<div class="creatorInfo">
						<img src="/imgs/creatorImg/creatorImg3.jpg">
						<p class="creatorNickname">팅민잉thingofmeaning</p>
					</div>
				</div>
				<div class="plLikeBox">
					<div>
						<i class="fa-regular fa-heart"></i>
						<span>LIKE 1,808</span>
					</div>
				</div>
			</div>
			<!-- 랭크 4 -->
			<div class="playlistCon">
				<img src="/imgs/playlistimg/list6.jpg">
				<div class="plContentsBox">
					<p class="plTitle">악기가 되어버린 천재를 아시오?</p>
					<p class="plTags">#노래모음 #플레이리스트 #playlist #플리 #딘</p>
					<div class="creatorInfo">
						<img src="/imgs/creatorImg/creatorImg4.jpg">
						<p class="creatorNickname">모기버섯ᴍᴏsǫᴜɪᴛᴏᴍᴜsʜʀᴏᴏᴍ</p>
					</div>
				</div>
				<div class="plLikeBox">
					<div>
						<i class="fa-regular fa-heart"></i>
						<span>LIKE 1,581</span>
					</div>
				</div>
			</div>
			<!-- 랭크 5 -->
			<div class="playlistCon">
				<img src="/imgs/playlistimg/list7.jpg">
				<div class="plContentsBox">
					<p class="plTitle">여름, 한국, 보사노바</p>
					<p class="plTags">#mixset #가요 #보사노바 #bossanova</p>
					<div class="creatorInfo">
						<img src="/imgs/creatorImg/creatorImg5.jpg">
						<p class="creatorNickname">츠미tsumi</p>
					</div>
				</div>
				<div class="plLikeBox">
					<div>
						<i class="fa-regular fa-heart"></i>
						<span>LIKE 1,375</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 검색한 플레이리스트 전체 조회 -->
	<div class="searchContainer">
		<div class="searchCon">
			<div class="searchBox">
				<form class="mainSearchBox" action="searchPlaylist">
					<select name="select">
						<option value="title">Title</option>
						<option value="tag">Tag</option>
					</select>
					<input type="text" placeholder="Search Playlist..." name="search">
					<button id="searchPlBtn" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
			<div class="searchListMain">
				<c:forEach items="${searchTag}" var="searchPlaylist">
					<a href="/showPlaylistInfo?plCode=${searchPlaylist.plCode}">
						<div class="playlistCon">
							<img src="${searchPlaylist.plImg}">
							<div class="plContentsBox">
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
							<div class="plLikeBox">
								<div>
									<i class="fa-regular fa-heart"></i>
									<span>LIKE 0</span>
								</div>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<jsp:include page="../tiles/footer.jsp"></jsp:include>
	</div>
</body>
</html>