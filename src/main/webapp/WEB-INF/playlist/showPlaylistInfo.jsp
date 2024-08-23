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
<link rel="stylesheet" href="./css/showPlaylistInfo.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js" crossorigin="anonymous"></script>
<script src="showPlaylistInfo.js" defer></script>
<title>플레이리스트 곡 조회</title>
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
      <div class="myTagBox">
      	<div class="PlaylistInfoBox">
    		<div class="playlistImg">
				<img src="${playlist.plImg}">
			</div>
				<p class="plTitle">${playlist.plTitle}
				<c:choose>
					<c:when test="${searchPlaylist.plPublicYn == 89}">
						<i class="fa-solid fa-lock-open"></i>
					</c:when>
					<c:otherwise>
						<i class="fa-solid fa-lock"></i>
					</c:otherwise>
				</c:choose>
				</p>
				<div class="playlistTagBox">
					<ul class="plTags">
						<p> #태그 영역 #태그 #해시태그 #집에가고싶다 </p>
		        		<c:forEach items="${tagList}" var="tag">
							<li>${tag}</li>
						</c:forEach>
					</ul>
				</div>
			<c:if test="${user.userEmail eq playlist.user.userEmail}">
			<div class="playlistInfoBox">
				<div class="creatorInfo">
					<img src="${user.userImg}">
					<p class="creatorNickname">${user.userNickname}</p>
					<!-- 링크 공유하기 -->
					<div class="playlistShareBtn">
						<i id="link-copy-icon" class="fa-solid fa-link" style="cursor:pointer;"></i>
						<span id="copy-message">링크가 복사되었습니다!</span>
					</div>
					<nav class="playlistMenuBox">
						<div class="playlistmenuBtn">
							<a href="#" class="plMenuBtn"><i class="fa-solid fa-minus"></i></a>
						</div>
						<div class="playlistMenu">
							<div class="plUpdateMenu"><a href="updatePlaylist?plCode=${playlist.plCode }">수정하기</a></div>
							<div class="plTagUpdateMenu"><a href="${pageContext.request.contextPath}/playlist/manageTags?plCode=${playlist.plCode}">태그 수정</a></div>
							<div class="plDeleteMenu"><a href="#" onclick="confirmDelete(event, 'deletePlaylist?plCode=${playlist.plCode }')">플레이리스트 삭제하기</a></div>
						</div>
					</nav>
				</div>
			</div>
			</c:if>
		<div class="addMusicBtnBox" onclick="location.href='addMusic?plCode=${playlist.plCode}'">
			<div class="addMusicBtnIcon">
				<a href="addMusic?plCode=${playlist.plCode}"><i class="fa-solid fa-plus"></i></a>
			</div>
			<div class="addMusicBtn">
				<a href="addMusic?plCode=${playlist.plCode}">이 플레이리스트에 추가</a>
			</div>
		</div>
	<!-- 플레이리스트 목록으로 -->
	<a href="myPlaylist" class="goPlaylistListBtn"><i class="fa-solid fa-arrow-left"></a></i>

	<form action="deleteMusicFromPlaylist" method="post" onsubmit="checkForSelectedMusic(event)">
	<input type="hidden" name="plCode" value="${playlist.plCode}">
		<div class="playlistListBox">
	        <c:forEach items="${musicList}" var="music" varStatus="status">
	            <div class="playlistList">
	            <!-- 주석 지우면 안 됨! 체크박스 작업중
		            <div class="radioCheckBox">
						<input type="checkbox" name="selectedDeleteMusic" value="${music.id}" id="radioCheck">
						<label for="radioCheck"></label>
					</div>
				-->
	                <img src="${music.albumUrl}" class="albumImg">
	                <div class="plMusicInfo">
	                    <div class="musicTitle">${music.musicTitle}</div>
	                    <div class="artistName">${music.artistName}</div>
	                    <!-- <a href="musicDetail?musicId=${music.id}">${music.albumName}</a> -->
	                </div>
	                <div class="plMusicAction">
						<a href="#" onclick="playMusic('${music.id}')" class="musicPlayBtn"><i class="fa-solid fa-circle-play"></i></a>
	                    <a href="#"><i class="fa-solid fa-ellipsis-vertical"></i></a>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	<button type="submit">곡 삭제</button>
	</form>

	<!-- 플레이어가 표시될 위치 -->
	<div id="playerContainer" style="margin-top: 20px;">
		<iframe id="main_frame" src="" width="300" height="380"
			frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
	</div>
</div>
</div>
</div>
</div>
</div>
</div>

<script>
    document.querySelector('.plMenuBtn').addEventListener('click', function(event) {
        event.preventDefault(); // 링크 기본 동작 방지
        const menu = document.querySelector('.playlistMenu');
        // 메뉴가 보이는 상태인지 확인하고, 보이거나 숨기기
        if (menu.style.display === 'block') {
            menu.style.display = 'none';
        } else {
            menu.style.display = 'block';
        }
    });

    // 페이지 클릭 시 메뉴를 숨기기 (메뉴 외부 클릭 시)
    document.addEventListener('click', function(event) {
        const menu = document.querySelector('.playlistMenu');
        const menuBtn = document.querySelector('.plMenuBtn');
        if (!menu.contains(event.target) && !menuBtn.contains(event.target)) {
            menu.style.display = 'none';
        }
    });

    document.querySelector('.addMusicBtnBox').addEventListener('click', function() {
        window.location.href = 'addMusic?plCode=${playlist.plCode}';
    });

		// 플레이리스트 삭제 클릭 시 바로 삭제되는 것 alert으로 방지
		function confirmDelete(event, url) {
			event.preventDefault(); // 링크 클릭 기본 동작 방지
			if (confirm('[${playlist.plTitle}] 플레이리스트를 삭제하시겠습니까?')) {
				window.location.href = url; // 확인 클릭 시 삭제 URL로 이동
			}
		}
		
		// [곡 삭제] 버튼 클릭 시 삭제할 곡이 있는지(체크된 곡이 있는지) 확인
		function checkForSelectedMusic(event) {
			const checkbox = document.querySelectorAll('input[name="selectedDeleteMusic"]:checked');
			if(checkbox.length === 0) {
				event.preventDefault(); // 폼 제출(삭제) 방지
				alert('삭제할 곡이 없습니다. 확인해 주세요.');
			}
		}
		
		// 페이지 로드 시 스크롤 위치 복원
		window.addEventListener('load', () => {
			// 페이지가 다른 페이지에서 왔는지 확인
			const isHistoryState = window.history.state && window.history.state.scrollRestoration;
	
			if (isHistoryState) {
				const scrollPosition = sessionStorage.getItem('scrollPosition');
				if (scrollPosition !== null) {
					window.scrollTo(0, parseInt(scrollPosition, 10));
					sessionStorage.removeItem('scrollPosition'); // 위치 복원 후 제거
				} else {
					// 처음 로드할 때는 페이지 상단으로 이동
					window.scrollTo(0, 0);
				}
			}
		});
		
		// 페이지를 떠나기 전 스크롤 위치 저장
		window.addEventListener('beforeunload', () => {
			sessionStorage.setItem('scrollPosition', window.scrollY);
			// 상태를 history에 저장
	        window.history.replaceState({scrollRestoration: true}, null);
		});
		
		<!-- 플레이리스트 링크 공유 -->
		async function onClickCopyLink() {
			const link = window.location.href;
			await
			navigator.clipboard.writeText(link);
			window.alert('클립보드에 링크가 복사되었습니다.');
		}
	
		document.getElementById("link-copy-icon").addEventListener("click", onClickCopyLink);

        // 곡을 재생하는 함수 (전역 범위에서 정의)
        function playMusic(trackId) {
            const iframe = document.getElementById("main_frame");
            iframe.src = "https://open.spotify.com/embed/track/" + trackId;
        }


    // 음악을 재생하는 함수
    function playMusic(trackId) {
        const iframe = document.getElementById("main_frame");
        // 자동 재생을 위해 autoplay 파라미터 추가
        iframe.src = "https://open.spotify.com/embed/track/" + trackId + "?autoplay=1";
    }

  
    // 링크 복사 기능 구현
    document.getElementById("link-copy-icon").addEventListener('click', function() {
        const dummy = document.createElement('input');
        const url = window.location.href;
        
        document.body.appendChild(dummy);
        dummy.value = url;
        dummy.select();
        document.execCommand('copy');
        document.body.removeChild(dummy);

        // 링크가 복사되었다는 메시지 표시
        const copyMessage = document.getElementById("copy-message");
        copyMessage.style.display = 'inline';
        setTimeout(function() {
            copyMessage.style.display = 'none';
        }, 2000); // 2초 후 메시지 숨김
    });
</script>
</body>
</html>