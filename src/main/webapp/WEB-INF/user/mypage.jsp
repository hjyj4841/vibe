<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css">
<link rel="stylesheet" href="./css/mypage.css">
<title>my page</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="mypageBox">
				<div class="myLeft">
					<div class="myProfile">
						<div class="myImg">
							<img alt="회원이미지" src="${user.userImg }">
						</div>
						<p class="myNick">${user.userNickname }</p>
						<p class="myEmail">${user.userEmail }</p>
						<c:choose>
							<c:when test="${user.userSpotifyYn == 89}">
								<div class="connectSpotify spotifyInfo">
									<i class="fa-brands fa-spotify"></i>
									<span>connected</span>
								</div>
							</c:when>
							<c:otherwise>
								<div class="disconnectSpotify spotifyInfo">
									<i class="fa-brands fa-spotify"></i>
									<span>disconnected</span>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="myList">
						<div>
							<a href="/">
								<i class="fa-solid fa-house-user"></i>
								<span>Home</span>
							</a>
						</div>
						<div>
							<a href="myPlaylist">
								<i class="fa-solid fa-circle-play"></i>
								<span>My PlayList</span>
							</a>
						</div>
						<div>
							<a>
								<i class="fa-brands fa-gratipay"></i>
								<span>Like PlayList</span>
							</a>
						</div>
						
					</div>
					<div class="myChangeInfo">
						<div>
							<a>
								<i class="fa-solid fa-gear"></i>
								<span>Edit Profile</span>
							</a>
						</div>
						<div>
							<a href="deleteUser">
								<span>delete ID</span>
							</a>
						</div>
					</div>
				</div>
				<div class="myRight">
					<div class="myTagBox">
						<div>
							My Favorite Tags
						</div>
						<div class="myTags">
							<div>
								<div>
									<img src="./imgs/tag/tag_img1.jpg">
									<span>#Rock</span>
								</div>
							</div>
							<div>
								<div>
									<img src="./imgs/tag/tag_img2.png">
									<span>#Pop</span>
								</div>
							</div>
							<div>
								<div>
									<img src="./imgs/tag/tag_img3.png">
									<span>#Dance</span>
								</div>
							</div>
							<div>
								<div>
									<img src="./imgs/tag/tag_img4.jpg">
									<span>#Metal</span>
								</div>
							</div>
							<div>
								<div>
									<img src="./imgs/tag/tag_img5.jpg">
									<span>#Hiphop</span>
								</div>
							</div>
						</div>
					</div>
					<div class="myEtcBox">
						<div>넣을게 없어...</div>
						<div>컨텐츠가 없어...</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../tiles/footer.jsp"></jsp:include>
	</div>


	<%-- ascii code : 89 == Y --%>
	<%-- 
	
	<div>${user.userPhone }</div>
	<fmt:formatDate value="${user.userDate}" pattern="yyyy-MM-dd" />
	<fmt:formatDate value="${user.userBirth}" pattern="yyyy-MM-dd" />
	<a href="deleteUser">회원탈퇴</a> 
	--%>
</body>
</html>