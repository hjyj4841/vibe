<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>




	<!-- 카카오톡 공유하기 -->
	<a id="kakaotalk-sharing-btn" href="javascript:;"> <img
		src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
		alt="카카오톡 공유 보내기 버튼" />
	</a>

	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
		integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4"
		crossorigin="anonymous"></script>
	<script>
		Kakao.init('73e5ba36f398f0540e77e864991716b4');
	</script>
	<script>
		var userNickname = "${user.userNickname}";
		var userImg = 'https://ifh.cc/g/rabxOW.jpg';
if (userImg!==null){
	alert(userImg);}
		document.getElementById("kakaotalk-sharing-btn").addEventListener(
				"click", function() {
					Kakao.Share.sendCustom({
						templateId : 111024,
						templateArgs : {
							'userNickname' : userNickname,
							'userImg' : userImg
						}
					});
				});
	</script>
	
	
	<i id="link-copy-icon" class="fa-solid fa-link"></i>
	<script>
		async function onClickCopyLink() {
			const link = window.location.href;
			await
			navigator.clipboard.writeText(link);
			window.alert('클립보드에 링크가 복사되었습니다.');
		}

		document.getElementById("link-copy-icon").addEventListener("click",
				onClickCopyLink);
	</script>
	
	<!-- 내 프로필 공유 -->
	<i id="link-copy-icon" class="fa-solid fa-link"></i>
	<script>
		async function onClickCopyLink() {
			const link = window.location.href;
			await
			navigator.clipboard.writeText(link);
			window.alert('클립보드에 링크가 복사되었습니다.');
		}

		document.getElementById("link-copy-icon").addEventListener("click",
				onClickCopyLink);
	</script>

</body>
</html>