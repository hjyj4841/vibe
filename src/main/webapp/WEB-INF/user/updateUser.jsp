<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/imgs/logo/logoB_small.png">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/likePlaylist.css" />
<title>VibeMaster</title>
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
						<div>Edit Profile</div>
						<sec:authorize access="isAuthenticated()" var="principal">
							<sec:authentication property="principal" var="user" />
							<form class="editForm" action="updateUser" method="post" onsubmit="return validate()" enctype="multipart/form-data">
								<input type="hidden" value="${user.userImg}" name="userImg" class="userImg">
								<div class="editUserImgBox">
									<div>
										<img src="${user.userImg}" class="userImgView">
										<div class="changeUserImg">
											<input name="file" type="file" accept="image/*" class="imgFile">
											<div>
												<p>empty</p>
												<i class="fa-solid fa-camera-rotate"></i>
												<p>Change Image</p>
											</div>
										</div>
										<div class="defaultUserImg">
											<button type="button" class="deleteImgBtn">Default Image</button>
										</div>
									</div>
								</div>
								<div class="textAndIcon">
									<input type="text" name="userNickname" class="nickname" value="${user.userNickname}" placeholder="${user.userNickname}" readonly required /> 
									<i class="fa-solid fa-pen" id="nicknanmeChangeBtn"></i>
								</div>
								<div class="textAndIcon">
									<input type="text" name="userPhone" value="${user.userPhone}" class="phoneNum" placeholder="${user.userPhone}" maxlength="13" readonly required /> 
									<i class="fa-solid fa-pen" id="phoneNumChangeBtn"></i>
								</div>
								<div>
									<input type="password" placeholder="Password" name="userPassword" class="userPassword" required />
								</div>
								<div class="editButtonBox">
									<div>
										<button type="submit" class="editBtn">Save</button>
										<button type="button" class="editCancel" onclick="location.href='/cancelUpdate'">Cancel</button>
									</div>
									<a href="/changePassword">Change Password</a>
								</div>
							</form>
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
        const DEFAULT_IMAGE_URL = 'http://192.168.10.6:8080/img/user_img/default_user.jpg'; // 기본 이미지 URL 설정

        let nicknameCheck = true;
        let phoneCheck = true;
        let passwordCheck = false;
        let isDefaultImage = false;

        $("#nicknanmeChangeBtn").click(() => {
            $(".nickname").attr('readonly', false)
            .css({'color': 'white', 'border-bottom': '1px solid red'})
            .focus().val('');
            nicknameCheck = false;
        });

        $("#phoneNumChangeBtn").click(() => {
            $(".phoneNum").attr('readonly', false)
            .css({'color': 'white', 'border-bottom': '1px solid red'})
            .focus().val('');
            phoneCheck = false;
        });

        $(".nickname").keyup(() => {
            $.ajax({
                type: "post",
                url: "/nicknameUpdate",
                data: {
                    userNickname: $(".nickname").val()
                },
                success: function(check){
                    if($(".nickname").prop('readonly') == true){
                        $(".nickname").css("border-bottom", "1px solid #333");
                        phoneCheck = true;
                    } else {
                        if(check) {
                            if($(".nickname").val() != ''){
                                $(".nickname").css('border-bottom', '1px solid green');
                                nicknameCheck = true;
                            } else {
                                $(".nickname").css('border-bottom', '1px solid red');
                                nicknameCheck = false;
                            }
                        } else {
                            $(".nickname").css('border-bottom', '1px solid red');
                            nicknameCheck = false;
                        }
                    }
                }
            });
        });

        $(".phoneNum").keyup(() => {
            const regExp = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;
            
            $(".phoneNum").val($(".phoneNum").val().replace(/[^0-9]/gi, ""));
            $(".phoneNum").val($(".phoneNum").val().replace(/[^0-9]/gi, "").replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
            
            if($(".phoneNum").prop('readonly') == true){
                $(".phoneNum").css("border-bottom", "1px solid #333");
                phoneCheck = true;
            } else {
                if(regExp.test($(".phoneNum").val())){
                    $(".phoneNum").css("border-bottom", "1px solid green");
                    phoneCheck = true;
                } else {
                    $(".phoneNum").css("border-bottom", "1px solid red");
                    phoneCheck = false;
                }
            }
        });

        $(".userPassword").keyup(() => {
            $.ajax({
                type: 'post',
                url: '/passwordCheck',
                data:{
                    userPassword: $(".userPassword").val()
                },
                success: function(data){
                    passwordCheck = data;
                }
            });
        });

        $(".imgFile").change(() => {
            const form = $('.editForm')[0];
            const formData = new FormData(form);
            isDefaultImage = false; // 이미지 파일을 선택하면 기본 이미지 사용 플래그를 초기화
            $.ajax({
                type: 'post',
                url: '/previewImg',
                data: formData,
                contentType: false,
                processData: false,
                success: function(fileUrl){
                    $(".userImgView").attr('src', fileUrl);
                }
            });
        });

        // Delete Img 버튼 클릭 시 기본 이미지로 변경
        $(".deleteImgBtn").click(() => {
            isDefaultImage = true;
            $(".userImgView").attr('src', DEFAULT_IMAGE_URL + '?' + new Date().getTime()); // 프론트엔드에서 이미지 src를 기본 이미지로 변경
            $(".imgFile").val(""); // 파일 입력 필드 초기화
            alert("프로필 이미지가 기본 이미지로 변경되었습니다.");
        });

        function validate(){
            if(!nicknameCheck) alert("현재 닉네임은 사용 불가능 합니다.");
            if(!phoneCheck) alert("알맞은 전화번호 형식을 입력해주세요.");
            if(!passwordCheck) alert("패스워드가 일치하지 않습니다.");

            if(isDefaultImage) {
                $(".userImg").val(DEFAULT_IMAGE_URL); // 기본 이미지를 사용하기로 했을 때 userImg hidden 필드에 기본 이미지 URL을 설정
            }

            return nicknameCheck && phoneCheck && passwordCheck;
        }
    </script>
</body>
</html>