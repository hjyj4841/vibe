<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>플레이리스트 세부정보</title>
    <!--
	<script>
	    document.addEventListener('DOMContentLoaded', function() {
	        // 로컬 스토리지에서 현재 플레이리스트 번호를 가져옵니다.
	        let playlistNumber = localStorage.getItem('playlistNumber');
	        
	        // 번호가 없으면 기본값을 설정합니다.
	        if (!playlistNumber) {
	            playlistNumber = 1;
	        } else {
	            playlistNumber = parseInt(playlistNumber) + 1;
	        }
	        
	        // 새로운 기본값을 입력 필드에 설정합니다.
	        document.getElementById('plTitle').value = '플레이리스트 #' + playlistNumber;
	        
	        // 업데이트된 번호를 로컬 스토리지에 저장합니다.
	        localStorage.setItem('playlistNumber', playlistNumber);
	    });
	</script>
	-->
	
	<style>
    /* 입력 필드의 텍스트가 숨겨지도록 스타일링 */
    .hidden-value::after {
        content: attr(data-placeholder);
        color: #888; /* Placeholder color */
        position: absolute;
        pointer-events: none;
    }
    .hidden-value {
        color: transparent;
        text-shadow: 0 0 0 #000; /* Same as background to ensure invisibility */
        position: relative;
    }
	</style>
	<script>
	    document.addEventListener('DOMContentLoaded', function() {
	        let playlistNumber = localStorage.getItem('playlistNumber');
	        
	        if (!playlistNumber) {
	            playlistNumber = 1;
	        } else {
	            playlistNumber = parseInt(playlistNumber) + 1;
	        }
	        
	        let inputField = document.getElementById('plTitle');
	        inputField.value = '내 플레이리스트 #' + playlistNumber;
	        inputField.setAttribute('data-placeholder', '내 플레이리스트 #' + playlistNumber);
	        
	        localStorage.setItem('playlistNumber', playlistNumber);
	    });
	</script>
  </head>
  <body>
  	<!-- <img src="${plImg}" alt="플레이리스트 이미지" style="max-width: 100%; height: auto;" /> -->
  	<img src="${pageContext.request.contextPath}/imgs/createplaylistimg/defaultCD.png" alt="defaultImg" style="max-width: 200px; height: auto;" />
    <h1>${plTitle}</h1>
    <form action="addMusic" method="post">
	<label><button type="submit">+</button></label>
    	<label for="addMusicThisPlaylist">이 플레이리스트에 추가</label><br>
    </form>
  </body>
</html>
