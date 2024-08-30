<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/updatePlaylist.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js" crossorigin="anonymous"></script>
<title>플레이리스트 수정하기</title>
<script type="text/javascript">
	// [취소하기] 버튼 클릭 시 수정 취소 동시에 이전 화면으로
	function cancel() {
		window.history.back(); // 이전 페이지로 돌아가기
	}
	// 이미지 미리보기 기능
	function previewImg(event) {
		const file = event.target.files[0];
		if (file) {
			console.log(file);
			const reader = new FileReader();
			reader.onload = function(e) {
				const image = document.getElementById("playlistImg");
				image.src = e.target.result;
			};
			reader.readAsDataURL(file);
		}
	}
	
	// 기본 이미지 URL 변수로 지정
	const DEFAULT_IMAGE_URL = "http://192.168.10.6:8080/playlistImg/defaultCD.png";
	
	// 기본 이미지로 리셋 및 폼 데이터 업데이트
	function resetDefaultImg() {
		const img = document.getElementById("playlistImg");
		img.src = DEFAULT_IMAGE_URL;
		// 기본 이미지 정보 폼에 추가
		document.getElementById("imgChange").value = ""; // 파일 선택 초기화
		document.getElementById("defaultImg").value = DEFAULT_IMAGE_URL; // 기본 이미지 URL 추가
	}
</script>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="mypageBox">
			<!-- 로그인한 유저만 mypageLeft.jsp 보이게 -->
        	<c:if test="${not empty user}">
				<div class="myLeft">
					<jsp:include page="../tiles/mypageLeft.jsp"></jsp:include>
				</div>
        	</c:if>
		<div class="myRight">
		<div class="updatePlInfoMain">
			<div class="updatePlInfoBox">
				<form action="/updatePlaylist" method="post" enctype="multipart/form-data">
					<!-- 플레이리스트 코드와 수정할 제목을 입력 받음 -->
					<input type="hidden" value="${playlist.plCode}" name="plCode" />
					<div class="updatePlImg">
						<img src="${playlist.plImg}">
					</div>
						<div class="updatePlTitle">
							<input type="text" id="plTitle" name="plTitle" value="${playlist.plTitle}" placeholder="Playlist Title" />
							<c:choose>
								<c:when test="${searchPlaylist.plPublicYn == 89}">
									<i class="fa-solid fa-lock-open"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-solid fa-lock"></i>
								</c:otherwise>
							</c:choose>
						</div>
			
						<label for="imgChange">Change Image</label>
						<input type="file" id="imgChange" name="plImgFile" accept="image/*" onchange="previewImg(event)" />
						<input type="hidden" id="defaultImg" name="defaultImg" value="${playlist.plImg}" />
						
						<!-- 기본 이미지 URL 필드 추가 -->
						<button type="button" onclick="resetDefaultImg()">Default Image</button>
					</div>
					
					
					<br><br><br><br><br><br><br>
					<div class="button-group">
						<button type="submit">Save</button>
					</div>
					
					<!-- 이전 플레이리스트 화면으로 -->
					<a href="javascript:void(0);" onclick="cancel()" class="goPlaylistBtn"><i class="fa-solid fa-arrow-left"></i></a>
				</form>
			</div>
		</div>
		</div>
		</div>
	</div>
</div>
<script src="./js/scroll.js"></script>
</body>
</html>
