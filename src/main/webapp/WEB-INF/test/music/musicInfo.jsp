<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음악 정보</title>
</head>
<body>
	<%-- artistInfo.jsp에서 선택한 음악 정보를 playlist.jsp로 전달하고, 플레이리스트를 추가할 때 선택된 음악의 정보를 처리하는 것 --%>
	<h1>음악 정보</h1>
	<form action="addMusicInPlaylist" method="post">
	    <!-- 임시로 넣은 플레이리스트 값 추후 변경 예정 -->
		<input type="hidden" name="plCode" value="1">
		<table>
			<tr>
				<th>선택</th>
				<th>이미지</th>
				<th>앨범명</th>
				<th>아티스트명</th>
				<th>음악명</th>
			</tr>
			<c:forEach items="${musicData}" var="music">
				<tr>
					<td>
						<input type="checkbox" name="selectedMusic" value="${music.id}">
						<!-- <input type="button" name="select" value="플레이리스트에 추가하기"> -->
						<!-- artistInfo.jsp에서 체크박스로 선택된 음악을 playlist.jsp로 전달하는 작업은
						playlist.jsp에서 선택된 음악 목록을 올바르게 표시하고 처리하는 로직이 필요함.
						현재는 selectedMusic을 playlist.jsp에 전달하고 있으므로, 폼에서 이를 활용하여 플레이리스트를 추가하는 데 사용합니다. -->
					</td>
					<td><img alt="" src="${music.albumUrl}"></td>
					<td>${music.albumName}</td>
					<td>${music.artistName}</td>
					<td>${music.musicTitle}</td>
				</tr>
			</c:forEach>
		</table>
		<input type="submit" value="플레이리스트에 추가하기">
	</form>
	<a href="addMusic">검색</a>
</body>
</html>