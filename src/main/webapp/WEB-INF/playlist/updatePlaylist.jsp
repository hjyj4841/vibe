<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플레이리스트 수정하기</title>
<script type="text/javascript">
	// [취소하기] 버튼 클릭 시 수정 취소 동시에 이전 화면으로
	function cancel() {
		window.history.back(); // 이전 페이지로 돌아가기
	}
	
	
	// 이미지 미리보기 기능
	function previewImage(event) {
		const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const image = document.getElementById('playlistImage');
                image.src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
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
    <h1>플레이리스트 수정</h1>
    <form action="/updatePlaylist" method="post" enctype="multipart/form-data">
        <!-- 플레이리스트 코드와 수정할 제목을 입력 받음 -->
        <input type="hidden" value="${playlist.plCode }" name="plCode">
        
        <img src="${playlist.plImg}" style="width: 300px;">
        
        <label for="imgChange">이미지 변경</label>
        <!-- <input type="file" id="imgChange" name="plImg"> -->
        <input type="file" id="imgChange" name="plImg" accept="image/*" onchange="previewImage(event)" /><br><br>
        
        <label for="plTitle">플레이리스트 제목:</label>
        <input type="text" id="plTitle" name="plTitle" value="${playlist.plTitle }" required />
        
        <button type="submit">저장하기</button>
        <button type="button" onclick="cancel()">취소하기</button>
    </form>
</body>
</html>
