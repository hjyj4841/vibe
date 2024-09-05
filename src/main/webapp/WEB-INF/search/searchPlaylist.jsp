<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="icon" href="/imgs/logo/logoB_small.png">
<title>VibeMaster</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<!-- 랭킹화면 후에 jstl 처리로 간결해질 예정... -->
	<div class="rankContainer">
		<div class="rankBox">
			<c:if test="${not empty searchRank }">
				<c:if test="${dto.search == '' }">
					<h1>Popular TOP 5</h1>
				</c:if>
				<c:if test="${dto.search != '' }">
					<h1>'${dto.search }' By Popular TOP 5</h1>
				</c:if>
				
				<c:forEach items="${searchRank}" var="searchPlaylist" begin="0" end="4">
					<div class="playlistCon">
						<div class="plImgBox">
							<img src="${searchPlaylist.plImg}" data-code="${searchPlaylist.plCode}">
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
			</c:if>
			<c:if test="${empty searchRank }">
				<h1>'${dto.search }' is empty...</h1>
			</c:if>
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
					</select> <input type="text" placeholder="Search Playlist..." name="search" autocomplete="off" value="${dto.search }">
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
	<script>
	// 태그 안의 스크롤 위치 확인
	let page = 1;
	let select = "<c:out value='${dto.select}'/>";
	let search = "<c:out value='${dto.search}'/>";
	let codes = "<c:out value='${dto.codes}'/>";
	codes = codes.replace('[', '').replace(']', '').split(",");
	codes = codes.map(Number);
	
	$("#searchPlayATag").click(function(e) {
		e.preventDefault();
	});
	
	$(".searchListMain").scroll(function(){
		var innerHeight = $(this).innerHeight();
		var scroll = $(this).scrollTop() + $(this).innerHeight(); 
		var height = $(this)[0].scrollHeight;
		if(height === scroll){
			page++;
			$.ajax({
				url: "/limitList",
				type: "POST",
				data: {
					page: page,
					select: select,
					search: search,
					codes: codes
				},
				success:function(searchTag){
					let searchListMain = $(".searchListMain");
					$.each(searchTag, function(index, searchPlaylist){
						let searchItem = '<div class="playlistCon">' + 
								'<div class="plImgBox">' +
									'<img src="' + searchPlaylist.plImg + '" data-code="' + searchPlaylist.plCode + '">' + 
								'</div>' +
								'<div class="plContentsBox" data-code="' + searchPlaylist.plCode + '">' + 
									'<p class="plTitle">' + searchPlaylist.plTitle + '</p>' + 
									'<p class="plTags">';
									for(let tag of searchPlaylist.tagList) {
										searchItem += '#' + tag.tag.tagName;
									}
								searchItem += '</p>' +
									'<div class="creatorInfo">' + 
										'<img src="' + searchPlaylist.user.userImg + '">' + 
										'<p class="creatorNickname">' + searchPlaylist.user.userNickname + '</p>' + 
									'</div>' + 
								'</div>' + 
								'<div class="plLikeBox" data-code="' + searchPlaylist.plCode + '" onclick="clickLike(event)">' + 
									'<div>'; 
										if(searchPlaylist.plLike!=null){
											searchItem += '<i class="fa-solid fa-heart" id="redHeart"></i>';
										} else {
											searchItem += '<i class="fa-regular fa-heart"></i>';
										}
										searchItem += '<span> LIKE </span>' +
										'<span class="likeCount">' + searchPlaylist.likeCount + '</span>' +
									'</div>' + 
								'</div>' + 
							'</div>';
						searchListMain.append(searchItem);
					});
					$('.playlistCon img').click((e) => {
						location.href = "/showPlaylistInfo?plCode=" + e.target.getAttribute("data-code");
					});
					
					$('.plContentsBox').click((e) => {
						location.href = "/showPlaylistInfo?plCode=" + e.currentTarget.getAttribute("data-code");
					})
				}
			});
		}
	});
	
	$('.playlistCon img').click((e) => {
		location.href = "/showPlaylistInfo?plCode=" + e.target.getAttribute("data-code");
	});
	
	$('.plContentsBox').click((e) => {
		location.href = "/showPlaylistInfo?plCode=" + e.currentTarget.getAttribute("data-code");
	})
	
	function clickLike(event) {
		const plLike = event.currentTarget;
		$.ajax({
			type: 'post',
			url: '/userLike',
			data: {
				plCode: plLike.getAttribute("data-code")
			},
			success: function(data){
				const count = plLike.querySelector('.likeCount').innerHTML;
				if(data){
					plLike.querySelector('i').style.color = 'red';
					plLike.querySelector('i').setAttribute('class', 'fa-solid fa-heart');
					plLike.querySelector('.likeCount').innerHTML = Number(count) + 1;
				}else{
					plLike.querySelector('i').style.color = 'white';
					plLike.querySelector('i').setAttribute('class', 'fa-regular fa-heart');
					plLike.querySelector('.likeCount').innerHTML = Number(count) - 1;
				}
			},
			error: function(){
				alert("로그인 후 이용해 주세요.");
			}
		});
	}
	</script>
</body>
</html>