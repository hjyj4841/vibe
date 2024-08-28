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
<link rel="stylesheet" href="./css/likePlaylist.css" />
 <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.9.2/tagify.min.css"
    />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.9.6/tagify.min.js"></script>
<script src="./js/createPlaylist.js"></script>
<title>My Playlist</title>
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
						<div class="playlistCreateBox">
							<div class="createBtnBox">
								<a href="createPlaylist" id="createPlaylistLink"> <i
									class="fa-solid fa-plus"></i> Create Playlist
								</a>
							</div>
							<div>My Playlist</div>
							<div class="createPlaylistEmpty"></div>
						</div>
						<div class="searchListMain">
							<c:forEach items="${searchTag}" var="searchPlaylist">
								<div class="playlistCon">
									<div class="plImgBox">
										<img src="${searchPlaylist.plImg}"
											data-code="${searchPlaylist.plCode}">
									</div>
									<div class="plContentsBox" data-code="${searchPlaylist.plCode}">
										<p class="plTitle">${searchPlaylist.plTitle}
											<c:choose>
												<c:when test="${searchPlaylist.plPublicYn == 89}">
													<i class="fa-solid fa-lock-open"></i>
												</c:when>
												<c:otherwise>
													<i class="fa-solid fa-lock"></i>
												</c:otherwise>
											</c:choose>
										</p>
										<p class="plTags">
											<c:forEach items="${searchPlaylist.tagList}" var="tag">
												#${tag.tag.tagName} 
											</c:forEach>
										</p>
										<div class="creatorInfo">
											<img src="${searchPlaylist.user.userImg}">
											<p class="creatorNickname">${searchPlaylist.user.userNickname}</p>
										</div>
									</div>
									<div class="plLikeBox" data-code="${searchPlaylist.plCode}"
										onclick="clickLike(event)">
										<div>
											<c:choose>
												<c:when test="${not empty searchPlaylist.plLike}">
													<i class="fa-solid fa-heart" id="redHeart"></i>
												</c:when>
												<c:otherwise>
													<i class="fa-regular fa-heart"></i>
												</c:otherwise>
											</c:choose>
											<span>LIKE </span> <span class="likeCount">${searchPlaylist.likeCount }</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let page = 1;
		
		$(".searchListMain").scroll(function(){
			var innerHeight = $(this).innerHeight();
			var scroll = $(this).scrollTop() + $(this).innerHeight(); 
			var height = $(this)[0].scrollHeight;
			if(height === scroll){
				page++;
				$.ajax({
					url: "/limitMyList",
					type: "POST",
					data: {
						page: page
					},
					success:function(searchTag){
						let searchListMain = $(".searchListMain");
						$.each(searchTag, function(index, searchPlaylist){
							let searchItem = '<div class="playlistCon">' + 
									'<div class="plImgBox">' +
										'<img src="' + searchPlaylist.plImg + '" data-code="' + searchPlaylist.plCode + '">' + 
									'</div>' +
									'<div class="plContentsBox" data-code="' + searchPlaylist.plCode + '">' + 
										'<p class="plTitle">' + searchPlaylist.plTitle;
										if(searchPlaylist.plPublicYn == 'Y'){
											searchItem += '<i class="fa-solid fa-lock-open"></i>';
										}else{
											searchItem += '<i class="fa-solid fa-lock"></i>';
										}
										searchItem += '</p>' + '<p class="plTags">';
										for(let tag of searchPlaylist.tagList) {
											searchItem += '#' + tag.tag.tagName;
										}
									searchItem += '</p>' +
										'<div class="creatorInfo">' + 
											'<img src="' + searchPlaylist.user.userImg + '">' + 
											'<p class="creatorNickname">' + searchPlaylist.user.userNickname + '</p>' + 
										'</div>' + 
									'</div>' + 
									'<div class="plLikeBox" data-code="' + searchPlaylist.plCode + '" onclick="clickLike(event)">' + 
										'<div>'; 
											if(searchPlaylist.plLike!=null){
												searchItem += '<i class="fa-solid fa-heart" id="redHeart"></i>';
											} else {
												searchItem += '<i class="fa-regular fa-heart"></i>';
											}
											searchItem += '<span> LIKE </span>' +
											'<span class="likeCount">' + searchPlaylist.likeCount + '</span>' +
										'</div>' + 
									'</div>' + 
								'</div>';
							searchListMain.append(searchItem);
						});
						$('.playlistCon img').click((e) => {
							location.href = "/showPlaylistInfo?plCode=" + e.target.getAttribute("data-code");
						});
						
						$('.plContentsBox').click((e) => {
							location.href = "/showPlaylistInfo?plCode=" + e.currentTarget.getAttribute("data-code");
						})
					}
				});
			}
		});
		
		$('.playlistCon img').click((e) => {
			location.href = "/showPlaylistInfo?plCode=" + e.target.getAttribute("data-code");
		});
		
		$('.plContentsBox').click((e) => {
			location.href = "/showPlaylistInfo?plCode=" + e.currentTarget.getAttribute("data-code");
		});

		function clickLike(event) {
			const plLike = event.currentTarget;
			$.ajax({
				type: 'post',
				url: '/userLike',
				data: {
					plCode: plLike.getAttribute("data-code")
				},
				success: function(data){
					const count = plLike.querySelector('.likeCount').innerHTML;
					if(data){
						plLike.querySelector('i').style.color = 'red';
						plLike.querySelector('i').setAttribute('class', 'fa-solid fa-heart');
						plLike.querySelector('.likeCount').innerHTML = Number(count) + 1;
					}else{
						plLike.querySelector('i').style.color = 'white';
						plLike.querySelector('i').setAttribute('class', 'fa-regular fa-heart');
						plLike.querySelector('.likeCount').innerHTML = Number(count) - 1;
					}
				},
				error: function(){
					alert("로그인 후 이용해 주세요.");
				}
			});
		}
		
		document.addEventListener('DOMContentLoaded', function () {
		    // 플레이리스트 생성 버튼 클릭 시 이벤트 처리
		    document.getElementById('createPlaylistLink').addEventListener('click', function(e) {
		        e.preventDefault(); // 기본 링크 이동 방지

		        $.ajax({
		            url: "createPlaylist", // 여기에 플레이리스트 생성 폼을 제공하는 URL을 입력하세요.
		            type: "GET",
		            success: function(response) {
		                // AJAX 요청이 성공하면 response에 폼 HTML이 포함됩니다.
		                // 해당 폼을 페이지의 특정 영역에 삽입
		                document.querySelector('.myRight').innerHTML = response;

		                // 삽입된 폼 내의 스크립트가 실행되도록 처리
		                const scripts = document.querySelector('.myRight').getElementsByTagName('script');
		                for (let i = 0; i < scripts.length; i++) {
		                    eval(scripts[i].innerText);
		                }

		                // 기본 이미지 설정 및 태그 기능 초기화
		                initializeImagePreviewAndTagify();
		            },
		            error: function() {
		                alert("플레이리스트 생성 폼을 불러오는데 실패했습니다.");
		            }
		        });
		    });

		    function initializeImagePreviewAndTagify() {
		        const DEFAULT_IMAGE_URL = 'http://192.168.10.6:8080/playlistImg/defaultCD.png';
		        const imgElement = document.getElementById('createPlaylistImg');
		        const fileInput = document.getElementById('plUrl');
		        const resetButton = document.querySelector('button[type="button"]');

		        // 이미지 미리보기 기능
		        function previewImg(event) {
		            const file = event.target.files[0];
		            if (file) {
		                const reader = new FileReader();
		                reader.onload = function(e) {
		                    imgElement.src = e.target.result;
		                }
		                reader.readAsDataURL(file);
		            } else {
		                imgElement.src = DEFAULT_IMAGE_URL;
		            }
		        }

		        // 기본 이미지로 리셋 기능
		        function resetDefaultImg() {
		            imgElement.src = DEFAULT_IMAGE_URL;
		            fileInput.value = ""; // 파일 선택 초기화
		        }

		        // 태그 입력 필드 초기화
		        const input = document.querySelector('#tags');
		        new Tagify(input);

		        // 이미지 미리보기 및 기본 이미지 리셋 이벤트 연결
		        fileInput.addEventListener('change', previewImg);
		        resetButton.addEventListener('click', resetDefaultImg);

		        // 페이지 로드 시 기본 이미지 설정
		        imgElement.src = DEFAULT_IMAGE_URL;
		    }
		});
		</script>
</body>
</html>