<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="myProfile">
	<div class="myImg">
		<img alt="회원이미지" src="${user.userImg }">
	</div>
	<div class=shareMyProfile>
		<a href="/shareMyProfile"><p>SHARE Profile</p></a>
	</div>
	<p class="myNick">${user.userNickname }</p>
	<p class="myEmail">${user.userEmail }</p>
	<c:choose>
		<c:when test="${user.userSpotifyYn == 89}">
			<div class="confrnectSpotify spotifyInfo">
				<i class="fa-brands fa-spotify"></i> <span>connected</span>
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
		<a href="/"> <i class="fa-solid fa-house-chimney"></i> <span>Main</span>
		</a>
	</div>
	<div>
		<a href="mypage"> <i class="fa-solid fa-user"></i> <span>My Page</span>
		</a>
	</div>
	
	<div>
		<a href="myPlaylist"> <i class="fa-solid fa-circle-play"></i> <span>My
				PlayList</span>
		</a>
	</div>
	<div>
		<a href="likePlaylist"> <i class="fa-brands fa-gratipay"></i> <span>Like
				PlayList</span>
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