<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 
    <script>
        function displayCurrentDate() {
            var today = new Date();
            var day = today.getDate();
            var month = today.getMonth() + 1; // 월은 0부터 시작하므로 1을 더합니다.
            var year = today.getFullYear();
            var formattedDate = year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
            document.getElementById('current-date').textContent = formattedDate;
        }
        window.onload = displayCurrentDate; // 페이지가 로드되면 날짜를 표시합니다.
    </script>
 -->
</head>
<body>
	<%-- artistInfo.jsp에서 선택한 음악 정보를 playlist.jsp로 전달하고, 플레이리스트를 추가할 때 선택된 음악의 정보를 처리하는 것 --%>
	<h2>플레이리스트 곡 추가</h2>
	<!-- <form action="/addPlaylist" method="post"> -->
	<form action="/playlist" method="post">
		<table border="1">
			<tr>
				<th>플리 코드</th>
				<th>추가한 곡 앨범 이미지</th>
				<th>추가한 곡 앨범명</th>
				<th>추가한 곡 아티스트명</th>
				<th>추가한 음악명</th>
			</tr>
			<tr>
				<td>${music.id}</td>
				<td><img alt="" src="${music.albumUrl}"></td>
				<td>${music.albumName}</td>
				<td>${music.artistName}</td>
				<td>${music.musicTitle}</td>
				<!-- <input type="email" id="userEmail" name="userEmail" required> -->
			</tr>
		
		<%-- 
		 <c:if test="${not empty selectedMusic}">
	        <h3>선택된 음악 목록</h3>
	        <ul>
	            <c:forEach var="music" items="${selectedMusic}">
	                <li>
	                    <img src="${music[0]}" alt="Album Image">
	                    <p>앨범명: ${music[1]}</p>
	                    <p>아티스트: ${music[2]}</p>
	                    <p>곡명: ${music[3]}</p>
	                </li>
	            </c:forEach>
	        </ul>
	    </c:if>
		--%>
	</form>
</body>
</html>