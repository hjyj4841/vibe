<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/search.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/updatePlaylist.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.2/color-thief.umd.js"></script>
<!-- ColorThief 라이브러리 추가 -->
<script src="node_modules/colorthief/dist/color-thief.umd.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>플레이리스트 수정하기</title>
<script type="text/javascript">
	// [취소하기] 버튼 클릭 시 수정 취소 동시에 이전 화면으로
	function cancel() {
		window.history.back(); // 이전 페이지로 돌아가기
	}

	// 이미지 미리보기 기능
	function previewImg(event) {
		const file = event.target.files[0];
		if (file) {
			console.log(file);
			const reader = new FileReader();
			reader.onload = function(e) {
				const image = document.getElementById("playlistImg");
				image.src = e.target.result;

				 // ColorThief를 사용하여 이미지에서 색상 추출
	            const colorThief = new ColorThief();
	            const imgElement = document.getElementById("playlistImg");
	            imgElement.onload = function() {
	                const dominantColor = colorThief.getColor(imgElement);
	                console.log('Dominant Color from Uploaded Image:', dominantColor); // 추출된 색상 출력
	            };
	        };
	        reader.readAsDataURL(file);
		}
	}

	// 기본 이미지 URL 변수로 지정
	const DEFAULT_IMAGE_URL = "http://192.168.10.6:8080/playlistImg/defaultCD.png";

	// 기본 이미지로 리셋 및 폼 데이터 업데이트
	function resetDefaultImg() {
		const img = document.getElementById("playlistImg");
		img.src = DEFAULT_IMAGE_URL;
		// 기본 이미지 정보 폼에 추가
		document.getElementById("imgChange").value = ""; // 파일 선택 초기화
		document.getElementById("defaultImg").value = DEFAULT_IMAGE_URL; // 기본 이미지 URL 추가

		// 기본 이미지에서 색상 추출
	    const colorThief = new ColorThief();
	    img.onload = function() {
	        const dominantColor = colorThief.getColor(img);
	        console.log('Dominant Color from Default Image:', dominantColor); // 추출된 색상 출력
	    };
	}
</script>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="mypageBox">
				<!-- 이전 화면으로 -->
				<a href="javascript:void(0);" onclick="cancel()"
					class="goPlaylistBtn"><i class="fa-solid fa-arrow-left"></i></a>
				
				<div class="myLeft">
					<jsp:include page="../tiles/mypageLeft.jsp"></jsp:include>
				</div>
				<div class="myRight">
					<div class="updatePlInfoMain">
						<div class="updatePlInfoBox">
							<form action="/updatePlaylist" method="post"
								enctype="multipart/form-data">
								<!-- 플레이리스트 코드와 수정할 제목을 입력 받음 -->
								<input type="hidden" value="${playlist.plCode}" name="plCode" />
								<div class="updatePlImgBox">
									<div class="updatePlImg">
										<img src="${playlist.plImg}" id="playlistImg"
											class="playlistImg">
										<div class="changePlImg">
											<input type="file" id="imgChange" name="plImgFile"
												accept="image/*" onchange="previewImg(event)" />
											<div>
												<i class="fa-solid fa-camera-rotate"></i>
												<p>Change Image</p>
											</div>
										</div>
										<div class="defaultImg">
											<input type="hidden" id="defaultImg" name="defaultImg"
												value="${playlist.plImg}" />
											<button type="button" class="deleteImgBtn"
												onclick="resetDefaultImg()">Default Image</button>
										</div>
									</div>
								</div>
								<div class="updatePlTitle">
									<input type="text" id="plTitle" name="plTitle"
										value="${playlist.plTitle}" placeholder="Playlist Title" />

									<!-- 공개/비공개 설정 -->
									<div class="privateBox">
										
										<input type="radio" name="plPublicYn" value="Y" id="publicRadio" ${Character.toString(playlist.plPublicYn) eq "Y" ? "checked" : ""}> 
										<input type="radio" name="plPublicYn" value="N" id="privateRadio" ${Character.toString(playlist.plPublicYn) eq "N" ? "checked" : ""}>

										<c:if test='${Character.toString(playlist.plPublicYn) eq "Y"}'>
											<i class="fa-solid fa-lock-open"></i>
										</c:if>
										<c:if test='${Character.toString(playlist.plPublicYn) eq "N"}'>
											<i class="fa-solid fa-lock"></i>
										</c:if>

										<div class="toggleHidden"></div>
									</div>
								</div>
							</form>
						</div>


						<div class="editButtonBox">
							<div class="editButton">
								<button type="submit" class="editBtn">Save</button>
								<button type="button" class="editCancel"
									onclick="javascript:window.history.back();">Cancel</button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
   		const publicSelect = document.querySelector('.privateBox');
   		
   		if($("#publicRadio").is(":checked")) {
   			$(".toggleHidden").css({
   				left: '30px',
   				'background-color': '#315B52'
   			});
    		$('.privateBox').css('background-color', '#018B00');
    		$(".privateBox > i").css({
   				left: '0px'
   			})
   		}
   		
   		if($('#privateRadio').is(':checked')) {
   			$(".toggleHidden").css({
   				left: '0px',
   				'background-color' : '#810000'
   			})
    		$('.privateBox').css('background-color', '#B42021');
   			$(".privateBox > i").css({
   				left: '24px'
   			})
    	}
   		
   		// 공개 범위 선택
        function selectPublicBox() {
        	const moveRight = {transform: ['translate(40px, 0)']};
        	const moveLeft = {transform: ['translate(-40px, 0)']};
        	const option = {duration: 500};
        	
        	$(".privateBox > i").removeClass("fa-lock-open");
        	$(".privateBox > i").removeClass("fa-lock");
        	
        	if ($('#privateRadio').is(':checked')){
        		$('#privateRadio').removeAttr('checked');
        		$('#publicRadio').attr('checked', 'checked');
        		//$('#publicRadio').prop('checked', true);
        		$('.toggleHidden').animate({left: '30px'})
        			.css('background-color', '#315B52');
        		$('.privateBox').css('background-color', '#018B00');
        		$(".privateBox > i").css({
       				left: '0px'
       			}).addClass('fa-lock-open')
       			
        	} else {
        		//$('#privateRadio').prop('checked', true);
        		$('#publicRadio').removeAttr('checked');
        		$('#privateRadio').attr('checked', 'checked');
        		$('.toggleHidden').animate({left: '0px'})
        			.css('background-color', '#810000');
        		$('.privateBox').css('background-color', '#B42021');
        		$(".privateBox > i").css({
       				left: '24px'
       			}).addClass('fa-lock');
        	}
        }
   		
        publicSelect.addEventListener('click', selectPublicBox);
        
        
        document.addEventListener('DOMContentLoaded', function() {
            var inputElement = document.getElementById('plTitle');

            if (inputElement) {
                // 페이지 로드 시 입력 필드의 끝으로 커서 이동되어 있기
                inputElement.focus();
                var length = inputElement.value.length;
                inputElement.setSelectionRange(length, length);

                // 클릭 시 커서 위치 클릭한 위치로 이동
                inputElement.addEventListener('click', function(event) {
                    var offsetX = event.clientX - inputElement.getBoundingClientRect().left;
                    var value = inputElement.value;
                    //var inputWidth = inputElement.clientWidth;
                    //var charWidth = inputWidth / (value.length || 1);
                    var index = Math.min(value.length, Math.floor(offsetX / charWidth));
                    inputElement.setSelectionRange(index, index);
                });
            }
        });
        
   	</script>
	<script src="./js/scroll.js"></script>
	
</body>
</html>