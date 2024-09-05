<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()" var="principal">
	<sec:authentication property="principal" var="user" />

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
</sec:authorize>
<div class="myList">
	<div>
		<a href="/"> <i class="fa-solid fa-house-chimney"></i> <span>Main</span>
		</a>
	</div>
	<div>
		<a href="/mypage"> <i class="fa-solid fa-user"></i> <span>My
				Page</span>
		</a>
	</div>

	<div>
		<a href="/myPlaylist"> <i class="fa-solid fa-circle-play"></i> <span>My
				PlayList</span>
		</a>
	</div>
	<div>
		<a href="/likePlaylist"> <i class="fa-brands fa-gratipay"></i> <span>Like
				PlayList</span>
		</a>
	</div>
</div>
<div class="myChangeInfo">
	<div>
		<a href="/updateUser"> <i class="fa-solid fa-gear"></i> <span>Edit
				Profile</span>
		</a>
	</div>
	<div>
		<a class="deleteUser"> <span>delete ID</span>
		</a>
	</div>
</div>

<!-- 프로필 공유 관련 스크립트 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
	integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4"
	crossorigin="anonymous"></script>
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
		await
		navigator.clipboard.writeText(link);
		window.alert('클립보드에 링크가 복사되었습니다.');
	}

	document.getElementById("link-copy-icon").addEventListener("click",
			onClickCopyLink);
</script>