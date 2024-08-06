<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<!-- 플레이리스트 생성 -->
    	<h1>플레이리스트 생성</h1>
    	<!-- 브라우저가 폼 데이터를 저장하지 않도록 하는 속성 : autocomplete -->
    	<form action="createPlaylist" method="post" autocomplete="off">
    		<!-- 임시로 넣어둔 유저, 추후 로그인한 유저 정보로 수정 예정 -->
     		<input type="hidden" name="userEmail" value="agrigs9@opensource.org" />
      		<label for="plTitle">플레이리스트 제목 : </label>
      		<!-- 기본값은 JavaScript로 설정 -->
      		<!-- <input type="text" id="plTitle" name="plTitle" /> -->
      		<!-- 사용자가 플레이리스트 제목을 입력하지 않아도 기본값으로 "플레이리스트 #N" 설정 -->
      		<!-- <input type="text" id="plTitle" name="plTitle" value="#플레이리스트" /> -->
      		<!-- CSS와 JavaScript로 값을 숨깁니다 -->
      		<input type="text" id="plTitle" name="plTitle" class="hidden-value" />
      		
      		<button type="submit">플레이리스트 생성</button>
    	</form>
</body>
</html>