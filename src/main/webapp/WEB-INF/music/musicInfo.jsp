<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/musicInfo.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>음악 정보</title>
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
	      <div class="musicListInfoMain">

	<form action="addMusicToPlaylist" method="post">
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
						<input type="checkbox" name="selectedMusic" value="${music.id}" id="selectedMusic">
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
		<input type="submit" value="플레이리스트에 추가하기" id="musicExistsInPlaylist">
	</form>
	<a href="addMusic">검색</a>
	
	</div>
   </div>
   </div>
   </div>
	
	
	<script>
    $(document).ready(function() {
        $("input[name='selectedMusic']").change(function() {
            // 선택된 체크박스의 ID 값을 배열로 가져오기
            const selectedMusicId = $("input[name='selectedMusic']:checked").map(function() {
                return $(this).val();
            }).get();

            // 중복 체크 요청
            $.ajax({
                type: "post",
                url: "/checkMusicInPlaylist",
                data: { musicId: selectedMusicId },
                traditional: true, // 배열 전송 시 필요
                success: function(response) {
                    // 응답에 따라 사용자에게 결과를 알림
                    $("input[name='selectedMusic']").each(function() {
                        const musicId = $(this).val();
                        if (response.includes(musicId)) {
                            $(this).prop("checked", false);
                            alert("선택한 곡은 이미 플레이리스트에 있습니다.");
                        }
                    });
                },
                error: function(xhr, status, error) {
                    alert("서버와의 통신 오류: musicInfo.jsp " + error);
                }
            });
        });
    });
	</script>
</body>
</html>