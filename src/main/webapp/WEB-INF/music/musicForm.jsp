<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/musicForm.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js" crossorigin="anonymous"></script>
<script src="/js/searchMusic.js"></script>
<title>검색하기</title>
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
    	<div class="searchMusicMain">
			<div class="searchMusicBox">
				<form class="mainSearchBox" action="addMusic" method="post">
					<input type="text" placeholder="아티스트, 곡 제목 등 검색어를 입력하세요." name="musicName" id="musicName" required>
					<button id="searchBtn" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
				<div id="resultContainer"></div> <!-- 검색 결과를 표시할 영역 -->
			</div>
   		</div>
   	</div>
	</div>
	</div>
</div>
</body>
</html>
