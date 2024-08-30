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
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>

<title>플레이리스트 곡 조회</title>
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
					<div class="playlistInfoMain">
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
									<c:forEach items="${tags}" var="tag">
										<li>#${tag.tag.tagName}</li>
									</c:forEach>
								</ul>
							</div>

							<div class="playlistInfoBox">
								<div class="creatorInfo">
									<img src="${user.userImg}">
									<p class="creatorNickname">${user.userNickname}</p>
									<!-- 링크 공유하기 -->
									<div class="playlistShareBtn">
										<i id="link-copy-icon" class="fa-solid fa-link"
											style="cursor: pointer;" onclick="sharePlayList()"></i> <span
											id="copy-message">링크가 복사되었습니다!</span>
									</div>

									<c:if test="${not empty user}">
										<nav class="playlistMenuBox">
											<div class="playlistmenuBtn">
												<a href="#" class="plMenuBtn"><i
													class="fa-solid fa-minus"></i></a>
											</div>
											<div class="playlistMenu">
												<div class="plUpdateMenu">
													<a href="updatePlaylist?plCode=${playlist.plCode }"><i
														class="fa-solid fa-pen"></i>Edit</a>
												</div>
												<div class="plTagUpdateMenu">
													<a
														href="${pageContext.request.contextPath}/playlist/manageTags?plCode=${playlist.plCode}"><i
														class="fa-solid fa-hashtag"></i>Tag Edit</a>
												</div>
												<div class="plDeletePlMenu">
													<a href="#"
														onclick="confirmDelete(event, 'deletePlaylist?plCode=${playlist.plCode }')"><i
														class="fa-solid fa-minus"></i>Delete playlist</a>
												</div>
											</div>
										</nav>
									</c:if>
								</div>
							</div>
						</div>

						<!-- 사용자 로그인 상태에 따라 버튼 표시 -->
						<c:if test="${not empty user}">
							<!-- 현재 사용자가 생성자와 동일할 때만 표시 -->
							<c:if test="${user.userEmail eq playlist.user.userEmail}">
								<div class="addMusicBtnBox"
									onclick="location.href='addMusic?plCode=${playlist.plCode}'">
									<div class="addMusicBtnIcon">
										<a href="addMusic?plCode=${playlist.plCode}"><i
											class="fa-solid fa-plus"></i></a>
									</div>
									<div class="addMusicBtn">
										<a href="addMusic?plCode=${playlist.plCode}">Add to
											playlist</a>
									</div>
								</div>
							</c:if>
						</c:if>
						<c:if test="${not empty user}">
							<!-- 플레이리스트 목록으로 -->
							<a href="myPlaylist" class="goPlaylistListBtn"><i
								class="fa-solid fa-arrow-left"></i></a>
						</c:if>

						<form action="deleteMusicFromPlaylist" method="post"
							onsubmit="checkForSelectedMusic(event)">
							<input type="hidden" name="plCode" value="${playlist.plCode}">
							<div class="playlistListBox">
								<c:forEach items="${musicList}" var="music" varStatus="status">
									<div class="playlistList">
										<!-- 체크박스는 로그인한 사용자만 보이도록 유지 -->
										<c:if test="${not empty user}">
											<div class="radioCheckBox">
												<c:choose>
													<c:when test="${user.userEmail eq playlist.user.userEmail}">
														<input type="checkbox" name="selectedDeleteMusic"
															value="${music.id}" id="radioCheck${status.index}">
													</c:when>
													<c:otherwise>
														<input type="checkbox" name="selectedDeleteMusic"
															value="${music.id}" id="radioCheck${status.index}"
															class="hidden-checkbox">
													</c:otherwise>
												</c:choose>
												<label for="radioCheck${status.index}"></label>
											</div>
										</c:if>

										<img src="${music.albumUrl}" class="albumImg">
										<div class="plMusicInfo">
											<div class="musicTitle">${music.musicTitle}</div>
											<div class="artistName">${music.artistName}</div>
										</div>

										<!-- 로그인 여부와 상관없이 노래 재생 기능이 동작하도록 수정 -->
										<div class="playlistMusicActionBtn">
											<a href="#" onclick="playMusic('${music.id}')"
												class="musicPlayBtn" data-track-id="${music.id}"><i
												class="fa-solid fa-circle-play"></i></a>
										</div>
									</div>
								</c:forEach>
							</div>
							<button type="submit" class="deleteMusicBtn"
								onclick="checkForSelectedMusic(event)">
								<i class="fa-solid fa-trash-can-arrow-up"></i>
							</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 플레이어 모달 -->
	<div id="playerModal" class="playerModal" >
		<div class="modal-content">
			<span class="close">&times;</span>
			<iframe id="main_frame" src="" width="300" height="380"
				frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>
		</div>
	</div>

	<script>
	
	 // 음악을 재생하는 함수
    function playMusic(trackId) {
        const iframe = document.getElementById("main_frame");
        // 자동 재생을 위해 autoplay 파라미터 추가
        iframe.src = "https://open.spotify.com/embed/track/" + trackId + "?autoplay=1";
        // iframe.src = "https://open.spotify.com/embed/track/" + trackId;
    }
 
 // 플레이어 모달을 열고 닫는 기능 추가
    document.addEventListener('DOMContentLoaded', () => {
	    const modal = document.getElementById('playerModal');
	    const span = document.querySelector('.close');

    function openModal(trackId) {
        const iframe = document.getElementById('main_frame');
        iframe.src = "https://open.spotify.com/embed/track/" + trackId + "?autoplay=1";
        modal.style.display = 'block';
    }

    function closeModal() {
        modal.style.display = 'none';
        const iframe = document.getElementById('main_frame');
        iframe.src = ""; // 비우기 (혹은 stop 재생)
    }

 	// 모달을 열도록 하는 예시
    document.querySelectorAll('.musicPlayBtn').forEach(button => {
        button.addEventListener('click', (event) => {
            event.preventDefault(); // 링크 기본 동작 방지
            const trackId = button.getAttribute('data-track-id'); // trackId를 버튼에서 가져온다고 가정
            openModal(trackId);
        });
    });

 	// 닫기 버튼 클릭 시 모달 닫기
    span.addEventListener('click', () => {
        closeModal();
    });

    	  // 모달 외부 클릭 시 모달 닫기
    	  window.addEventListener('click', (event) => {
    	    if (event.target === modal) {
    	      closeModal();
    	    }
    	  });
    	});
		// 플레이리스트 메뉴 표시/숨기기
		document.querySelector('.plMenuBtn').addEventListener('click', function(event) {
			event.preventDefault();
			const menu = document.querySelector('.playlistMenu');
			menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
		});

		// 메뉴 외부 클릭 시 메뉴 숨기기
		document.addEventListener('click', function(event) {
			const menu = document.querySelector('.playlistMenu');
			const menuBtn = document.querySelector('.plMenuBtn');
			if (!menu.contains(event.target) && !menuBtn.contains(event.target)) {
				menu.style.display = 'none';
			}
		});

		// 플레이리스트 삭제 확인
		function confirmDelete(event, url) {
			event.preventDefault();
			if (confirm('[${playlist.plTitle}] 플레이리스트를 삭제하시겠습니까?')) {
				window.location.href = url;
			}
		}

		// 곡 삭제 확인
		function checkForSelectedMusic(event) {
			const checkbox = document.querySelectorAll('input[name="selectedDeleteMusic"]:checked');
			if (checkbox.length === 0) {
				event.preventDefault();
				alert('삭제할 곡이 없습니다. 확인해 주세요.');
			}
		}

		// 링크 공유 기능
		async function sharePlayList() {
			try {
				await navigator.clipboard.writeText(window.location.href);
				const copyMessage = document.getElementById("copy-message");
				copyMessage.style.display = 'inline';
				setTimeout(() => {
					copyMessage.style.display = 'none';
				}, 2000);
			} catch (err) {
				console.error('Failed to copy: ', err);
			}
		}

		   
			

		// 페이지 로드 시 체크박스 상태 초기화
		function resetCheckboxes() {
			document.querySelectorAll('input[name="selectedDeleteMusic"]').forEach(checkbox => {
				checkbox.checked = false;
			});
		}

		window.addEventListener('load', resetCheckboxes);

		// 체크박스 상태에 따라 삭제 버튼 표시 여부 결정
		function updateDeleteButtonVisibility() {
			const checkboxes = document.querySelectorAll('input[name="selectedDeleteMusic"]');
			const deleteButton = document.querySelector('.deleteMusicBtn');
			deleteButton.classList.toggle('showDeleteBtn', Array.from(checkboxes).some(checkbox => checkbox.checked));
		}

		document.addEventListener('change', (event) => {
			if (event.target.name === 'selectedDeleteMusic') {
				updateDeleteButtonVisibility();
			}
		});
	</script>
</body>
</html>