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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.9.2/tagify.min.css" />
<link rel="stylesheet" href="./css/likePlaylist.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.9.6/tagify.min.js"></script>
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
								<!-- 
								<a href="createPlaylist" id="createPlaylistLink"> <i
									class="fa-solid fa-plus"></i> Create Playlist
								</a>
							 -->
								<a id="createPlaylistLink" onclick="createPlaylistView()"> <i
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
												<c:when test="${Character.toString(searchPlaylist.plPublicYn) eq 'Y'}">
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
						});
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

		const createForm = 
			'<form class="playlistCon" id="createFormBox" action="createPlaylist" method="post" autocomplete="off" enctype="multipart/form-data">' +
			'<div class="plImgBox image-preview-container">' +
			'<div>' + 
			'<img src="http://192.168.10.6:8080/playlistImg/defaultCD.png" id="createPlaylistImg">' +
			'<div class="image-controls">' +
			'<div>' +
			'<input type="file" id="plUrl" name="plUrl" accept="image/*" />' +
			'<p>Change</p>' +
			'</div>' + 
			'<button type="button" class="defaultBtn">Default</button>' + 
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="plContentsBox" id="createConBox">' +
			'<input type="text" class="plTitle" id="plTitle" name="plTitle" placeholder="Type your Playlist title"  maxlength="100">' +
			'<input type="text" class="plTags" id="tags" name="tags" placeholder="add Tags">' +
			'</div>' +
			'<div class="createPlaylistRight">' +
			'<div class="privateBox">' +
			'<input type="radio" name="plPublicYn" value="Y" id="publicRadio">' +
			'<input type="radio" name="plPublicYn" value="N" id="privateRadio" checked>' +
			'<i class="fa-solid fa-lock-open"></i>' +
			'<i class="fa-solid fa-lock"></i>' +
			'<div class="toggleHidden"></div>' +
			'</div>' +
			'<div class="form-submit-container">' +
			'<button type="submit" class="successBtn">Create</button>' +
			'<button type="button" class="cancelBtn">Cancel</button>' +
			'</div>' +
			'</div>' +
			'</form>';
			
		function createPlaylistView(){
			$('#createPlaylistLink').css({'opacity': 0, 'cursor': 'default'}).attr('onclick', '');
			$('.searchListMain').prepend(createForm);
			initializeImagePreviewAndTagify();
			
			const DEFAULT_IMAGE_URL = 'http://192.168.10.6:8080/playlistImg/defaultCD.png';
		 	const imgElement = document.getElementById('createPlaylistImg');
	        const fileInput = document.getElementById('plUrl');
	        const resetButton = document.querySelector('.defaultBtn');
	        const cancelButton = document.querySelector('.cancelBtn');
	        const publicSelect = document.querySelector('.privateBox');
	        
	     	// 이미지 미리보기 기능
	        function previewImg(event) {
	            const file = event.target.files[0];
	            if (file) {
	                const reader = new FileReader();
	                reader.onload = function(e) {
	                    imgElement.src = e.target.result;
	                    imgElement.style.objectFit = 'cover';
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
	        
	        // 취소 버튼
	        function cancelFrom(){
	        	location.reload();
	        }
	        
	        // 공개 범위 선택
	        function selectPublicBox(){
	        	const moveRight = {transform: ['translate(40px, 0)']};
	        	const moveLeft = {transform: ['translate(-40px, 0)']};
	        	const option = {duration: 500};
	        	
	        	if($('#privateRadio').is(':checked')){
	        		$('#publicRadio').prop('checked', true);
	        		$('.toggleHidden').animate({left: '30px'})
	        			.css('background-color', '#315B52');
	        		$('.privateBox').css('background-color', '#018B00');
	        	}else{
	        		$('#privateRadio').prop('checked', true);
	        		$('.toggleHidden').animate({left: '0px'})
	        			.css('background-color', '#810000');
	        		$('.privateBox').css('background-color', '#B42021');
	        	}
	        }
	        
			// 이미지 미리보기 및 기본 이미지 리셋 이벤트 연결
	        fileInput.addEventListener('change', previewImg);
	        resetButton.addEventListener('click', resetDefaultImg);
	        cancelButton.addEventListener('click', cancelFrom);
	        publicSelect.addEventListener('click', selectPublicBox);
		}
		
		function initializeImagePreviewAndTagify(){
			// 태그 입력 필드 초기화
	        const input = document.querySelector('#tags');
	        new Tagify(input, {
	            maxTags: 5, 
	    		tagTextProp: 'value' // 태그의 텍스트 값 설정
	        });
	    
	   	// 엔터키로만 태그 추가
        input.addEventListener('keydown', function(event) {
            if (event.key === " ") {
                event.preventDefault();
            } else if (event.key === "Enter") {
                const value = input.value.trim();
                if (value.length > 0) {
                    tagify.addTags(value);
                    input.value = "";
                }
            }
        });
		}
	</script>
</body>
</html>