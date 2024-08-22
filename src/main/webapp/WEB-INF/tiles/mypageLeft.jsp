<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<a href="mypage"> <i class="fa-solid fa-user"></i> <span>My
				Page</span>
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
	<div>
		<a href="musicListen"> <i class="fa-solid fa-circle-play"></i> <span>MUSIC
				player</span>
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
		<a class="deleteUser"> <span>delete ID</span>
		</a>
	</div>
</div>

<script>
const deletTxt =
`※회원탈퇴 시 주의사항※
(1) 회원탈퇴 후 7일간 재가입 불가.
- 탈퇴회원의 정보도 7일간 보관.
(2) 탈퇴 시 작성한 플레이리스트는 관리자 계정으로 인계.
- 원치 않을 경우 플레이리스트 비공개 전환 및
  삭제 후 탈퇴 진행.`;
  
	$(".deleteUser").click((e) => {
		alert(deletTxt);
		const password = prompt('비밀번호를 입력해주세요.');
		if(password){
			if(confirm('회원탈퇴 하시겠습니까?')){
				$.ajax({
					url: '/deleteUser',
					type: 'post',
					data: {
						userPassword: password
					},
					success: function(data){
						if(data){
							alert('회원탈퇴 처리되었습니다.');
							window.location.href = '/';
						}else{
							alert('비밀번호가 일치하지 않습니다.');
							window.location.href = '/mypage';
						}
					}
				});
			} else alert('회원탈퇴 취소');
		} else alert('회원탈퇴 취소'); 
	});
</script>