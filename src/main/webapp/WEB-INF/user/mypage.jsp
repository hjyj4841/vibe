<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <jsp:include page="../tiles/mypageLeft.jsp"></jsp:include>
          </div>
          <div class="myRight">
            <div class="myTagBox">
              <div class="tagBoxTitle">My Favorite Tags</div>
              <div class="myTags">
              <c:choose>
              	<c:when test="${not empty likeTagList }">
              		<c:forEach var="tag" items="${likeTagList }" varStatus="status">
              			<div>
                  			<div class="moveTagSearch" data-code="${tag.tagName }">
                    			<img src="./imgs/tag/tag_img${status.count }.jpg" />
                    			<span>#${tag.tagName }</span>
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
              <!-- 제일인기 있는 나의 플레이리스트 -->
              <div class="myEtcLeft">
				<h1>My most popular playlist</h1> 
				<div>
				<!-- topPlaylist -->
				<c:if test="${topPlaylist != null }">
					<a href="/showPlaylistInfo?plCode=${topPlaylist.plCode}">
						<div class="etcCon">
							<img src="${topPlaylist.plImg }">
							<div class="etcDesc">
								<div>
									<div class="etcTitle">${topPlaylist.plTitle }</div>
										<div class="etcTag">
											<c:forEach items="${topPlaylist.tagList }" var="tag">
												#${tag.tag.tagName } 
											</c:forEach>
										</div>
										<div class="plLikeBox" data-code="${topPlaylist.plCode}">
											<c:choose>
												<c:when test="${not empty topPlaylist.plLike}">
													<i class="fa-solid fa-heart" id="redHeart"></i>
												</c:when>
												<c:otherwise>
													<i class="fa-regular fa-heart"></i>
												</c:otherwise>
											</c:choose>
											<span> Like </span>
											<span class="likeCount">${topPlaylist.likeCount }</span>
										</div>
									</div>
	                				<div>
	                					<div class="etcUserBox">
	                						<img src="${topPlaylist.user.userImg }" class="etcUserImg">
	                						<span class="etcUserNickname">
	                							${topPlaylist.user.userNickname }
	                						</span>
	                					</div>
	                				</div>
								</div>
							</div>
						</a>
					</c:if>
					<c:if test="${topPlaylist == null }">
						아직 생성한 플레이리스트가 없습니다.
					</c:if>
				</div>
			  </div>
			  <!-- 랜덤 추천 플레이리스트 -->
              <div class="myEtcRigth">
                <h1>Random recommended playlist</h1>
                <div>
                <!-- randomPlaylist -->
				<c:if test="${randomPlaylist != null }">
					<a href="/showPlaylistInfo?plCode=${randomPlaylist.plCode}">
						<div class="etcCon">
							<img src="${randomPlaylist.plImg }">
							<div class="etcDesc">
								<div>
									<div class="etcTitle">${randomPlaylist.plTitle }</div>
										<div class="etcTag">
											<c:forEach items="${randomPlaylist.tagList }" var="tag">
												#${tag.tag.tagName } 
											</c:forEach>
										</div>
										<div class="plLikeBox" data-code="${randomPlaylist.plCode}">
											<c:choose>
												<c:when test="${not empty randomPlaylist.plLike}">
													<i class="fa-solid fa-heart" id="redHeart"></i>
												</c:when>
												<c:otherwise>
													<i class="fa-regular fa-heart"></i>
												</c:otherwise>
											</c:choose>
											<span> Like </span>
											<span class="likeCount">${randomPlaylist.likeCount }</span>
										</div>
									</div>
	                				<div>
	                					<div class="etcUserBox">
	                						<img src="${randomPlaylist.user.userImg }" class="etcUserImg">
	                						<span class="etcUserNickname">
	                							${randomPlaylist.user.userNickname }
	                						</span>
	                					</div>
	                				</div>
								</div>
							</div>
						</a>
					</c:if>
					<c:if test="${randomPlaylist == null }">
						아직 생성된 플레이리스트가 없습니다.
					</c:if>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <jsp:include page="../tiles/footer.jsp"></jsp:include>
    </div>
    <script>
    	const moveTagSearch = document.querySelectorAll('.moveTagSearch');
    	
    	moveTagSearch.forEach(moveTag => {
    		moveTag.addEventListener("click", function(e){
    			const tag = moveTag.getAttribute("data-code");
    			window.location.href = '/searchPlaylist?select=tag&search=' + tag;
    		});
    	});

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
				});
			});
		});
		
		
    </script>
  </body>
</html>
