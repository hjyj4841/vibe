<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/mypage.css" />
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

							<!-- 회원 이미지 수정 로직 -->

							<a href="changeMyImg"><img alt="회원이미지" src="${user.userImg }"></a>
						</div>
						<div class=shareMyProfile>
							<a href="/shareMyProfile"><p>SHARE Profile</p></a>
						</div>
						<p class="myNick">${user.userNickname }</p>
						<p class="myEmail">${user.userEmail }</p>
						<c:choose>
							<c:when test="${user.userSpotifyYn == 89}">
								<div class="confrnectSpotify spotifyInfo">
									<i class="fa-brands fa-spotify"></i> 
										<span>connected</span>
								</div>
							</c:when>
							<c:otherwise>
								<div class="disconnectSpotify spotifyInfo">
									<i class="fa-brands fa-spotify"></i> <a href="/spotifyConnect"><span>disconnected</span></a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="myList">
						<div>
							<a href="/"> <i class="fa-solid fa-house-user"></i> <span>Home</span>
							</a>
						</div>
						<div>
							<a href="myPlaylist"> <i class="fa-solid fa-circle-play"></i>
								<span>My PlayList</span>
							</a>
						</div>
						<div>
							<a href="likePlaylist"> <i class="fa-brands fa-gratipay"></i>
								<span>Like PlayList</span>
							</a>
						</div>
					</div>
					<div class="myChangeInfo">
						<div>
							<a href="updateUser"> <i class="fa-solid fa-gear"></i> <span>Edit
									Profile</span>
							</a>
						</div>
						<div>
							<a href="deleteUser"> <span>delete ID</span>
							</a>
						</div>
					</div>
				</div>
				<div class="myRight">
					<div class="myTagBox">
						<div>My Favorite Tags</div>
						<div class="myTags">
							<c:choose>
								<c:when test="${not empty likeTagList }">
									<c:forEach var="tag" items="${likeTagList }" varStatus="status">
										<div>
											<div>
												<img src="./imgs/tag/tag_img${status.count }.jpg" /> <span>#${tag.tagName
													}</span>
												<!-- (좋아요 수: ${tag.tagCount}) -->
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
              		좋아요한 태그가 없습니다.
              	</c:otherwise>
							</c:choose>
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

</body>
</html>
