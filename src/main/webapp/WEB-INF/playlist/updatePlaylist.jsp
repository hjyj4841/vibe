<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/updatePlaylist.css" />
<title>플레이리스트 수정하기</title>
<link rel="stylesheet" href="./css/style.css" />
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/updatePlaylist.css" />
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
          reader.onload = function (e) {
            const image = document.getElementById("playlistImg");
            image.src = e.target.result;
          };
          reader.readAsDataURL(file);
        }
      }

      // 기본 이미지 URL 변수로 지정
      const DEFAULT_IMAGE_URL =
        "http://192.168.10.6:8080/playlistImg/defaultCD.png";

      // 기본 이미지로 리셋 및 폼 데이터 업데이트
      function resetDefaultImg() {
        const img = document.getElementById("playlistImg");
        img.src = DEFAULT_IMAGE_URL;

        // 기본 이미지 정보 폼에 추가
        document.getElementById("imgChange").value = ""; // 파일 선택 초기화
        document.getElementById("defaultImg").value = DEFAULT_IMAGE_URL; // 기본 이미지 URL 추가
      }
    </script>
<style>
/* 이미지 변경 클릭 시 파일 불러오기 시스템 버튼 형태 처리 */
/* 파일 입력 요소 숨기기 */
#imgChange {
	display: none;
}
/* label 스타일링 */
label[for="imgChange"] {
	cursor: pointer;
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<h1>Update Playlist</h1>
		<form action="/updatePlaylist" method="post"
			enctype="multipart/form-data">
			<!-- 플레이리스트 코드와 수정할 제목을 입력 받음 -->
			<input type="hidden" value="${playlist.plCode }" name="plCode" />

			<div class="form-section-img">
				<img src="${playlist.plImg}" style="width: 300px" id="playlistImg" />
				<div class="form-section-img-buttons">
				<label for="imgChange">Change Image</label> <input type="file"
					id="imgChange" name="plImgFile" accept="image/*"
					onchange="previewImg(event)" /> <input type="hidden"
					id="defaultImg" name="defaultImg" value="${playlist.plImg}" />
				<!-- 기본 이미지 URL 필드 추가 -->
				<button type="button" onclick="resetDefaultImg()">Default Image</button>
			</div>
			</div>

			<div class="form-section">
				<input type="text"
					id="plTitle" name="plTitle" placeholder="Type your New Playlist's title" />
			</div>

			<div class="button-group">
				<button type="submit">SAVE</button>
				<button type="button" onclick="cancel()">Cancel</button>
			</div>
		</form>
	</div>
	<script src="./js/scroll.js"></script>
</body>
</html>
