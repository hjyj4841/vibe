<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/likePlaylist.css" />
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
      <div class="con">
        <div class="mypageBox">
          <div class="myLeft">
            <jsp:include page="../tiles/mypageLeft.jsp"></jsp:include>
          </div>
          <div class="myRight">
            <div class="myTagBox">
              <div class="playlistCreateBox">
              	<div class="createBtnBox">
              		<a href="createPlaylist">
	              		<i class="fa-solid fa-plus"></i>
	              		Create Playlist
              		</a>
              	</div>
              	<div>My Playlist</div>
              	<div class="createPlaylistEmpty"></div>
              </div>
	              <div class="searchListMain">
					<c:forEach items="${searchTag}" var="searchPlaylist">
						<a href="/showPlaylistInfo?plCode=${searchPlaylist.plCode}">
							<div class="playlistCon">
								<img src="${searchPlaylist.plImg}">
								<div class="plContentsBox">
									<p class="plTitle">${searchPlaylist.plTitle}
										<c:choose>
											<c:when test="${searchPlaylist.plPublicYn == 89}">
												<i class="fa-solid fa-lock-open"></i>
											</c:when>
											<c:otherwise>
												<i class="fa-solid fa-lock"></i>
											</c:otherwise>
										</c:choose>
									</p>
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
								<div class="plLikeBox" data-code="${searchPlaylist.plCode}">
									<div>
										<c:choose>
											<c:when test="${not empty searchPlaylist.plLike}">
												<i class="fa-solid fa-heart" id="redHeart"></i>
											</c:when>
											<c:otherwise>
												<i class="fa-regular fa-heart"></i>
											</c:otherwise>
										</c:choose>
										<span>LIKE </span>
										<span class="likeCount">${searchPlaylist.likeCount }</span>
									</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
            </div>
          </div>
        </div>
      </div>
	</div>
	<script>
		const plLikeBox = document.querySelectorAll(".plLikeBox");
		
		plLikeBox.forEach(plLike => {
			plLike.addEventListener("click", function(e){
				e.preventDefault();
				
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
			});
		});
	
	</script>
</body>
</html>