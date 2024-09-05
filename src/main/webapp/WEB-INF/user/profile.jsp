<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="/css/reset.css" />
<link rel="stylesheet" href="/css/mypage.css" />
<link rel="stylesheet" href="/css/profile.css" />
<link rel="icon" href="/imgs/logo/logoB_small.png">
<title>VibeMaster</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="topLine">
		<div class="myProfile">
			<div class="myImg">
				<img alt="회원이미지" src="${user.userImg }">
			</div>
			<div class="shareProfile">
				<!-- 카카오톡 공유하기 -->
				<a id="kakaotalk-sharing-btn" href="javascript:;"> <img
					src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
					alt="카카오톡 공유 보내기 버튼" />
				</a>
				<!-- 일반 공유 -->
				<i id="link-copy-icon" class="fa-solid fa-link"></i>
			</div>

			<p class="myNick">${user.userNickname }</p>
			<p class="myEmail">${user.userEmail }</p>
		</div>

		<div class="myTagBox">
			<div class="tagBoxTitle">Favorite Tags</div>
			<div class="myTags">
				<c:choose>
					<c:when test="${not empty likeTag }">
						<c:forEach var="tag" items="${likeTag }" varStatus="status">
							<div>
								<div class="moveTagSearch" data-code="${tag.tagName }">
									<img src="/imgs/tag/tag_img${status.count }.jpg" /> <span>#${tag.tagName
										}</span>
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
	</div>
	<div class="listBoxTitle">PlayList</div>
	<div class="searchListMain">

		<c:forEach items="${playlistView }" var="searchPlaylist">
			<c:choose>
				<c:when test="${searchPlaylist.plPublicYn == '89'}">
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
						</div>
						<div class="creatorInfo">
							<img src="${searchPlaylist.user.userImg}">
							<p class="creatorNickname">${searchPlaylist.user.userNickname}</p>
						</div>
						<div class="plLikeBox" data-code="${searchPlaylist.plCode}"
							onclick="clickLike(event)">
							<div>
								<i class="fa-solid fa-heart" id="redHeart"></i><span> LIKE </span> <span
									class="likeCount">${searchPlaylist.likeCount }</span>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>

	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
		integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4"
		crossorigin="anonymous"></script>
	<script>
        Kakao.init('73e5ba36f398f0540e77e864991716b4');

        var userNickname = "${user.userNickname}";
        var userImg = "${user.userImg}";
        var userEmail = "${user.userEmail}"
        document.getElementById("kakaotalk-sharing-btn").addEventListener(
            "click", function() {
                Kakao.Share.sendCustom({
                    templateId : 111024,
                    templateArgs : {
                        'userNickname' : userNickname,
                        'userImg' : userImg,
                        'userEmail' : userEmail
                    }
                });
            });

        async function onClickCopyLink() {
            const link = "http://localhost:8080/profile/${user.userEmail}"
            await navigator.clipboard.writeText(link);
            window.alert('클립보드에 링크가 복사되었습니다.');
        }

        document.getElementById("link-copy-icon").addEventListener("click", onClickCopyLink);
        
        
        $('.playlistCon img').click((e) => {
			location.href = "/showPlaylistInfo?plCode=" + e.target.getAttribute("data-code");
		});
		
		$('.plContentsBox').click((e) => {
			location.href = "/showPlaylistInfo?plCode=" + e.currentTarget.getAttribute("data-code");
		});
    </script>
</body>
</html>