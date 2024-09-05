<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/mypage.css" />
<link rel="stylesheet" href="./css/likePlaylist.css" />
<link rel="icon" href="/imgs/logo/logoB_small.png">
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
						<div>Change Password</div>
						<form class="editForm" action="changePassword" method="post" onsubmit="return validate()">
							<div>
								<input type="password" class="changePassword" name="changePassword"
									placeholder="변경할 PASSWORD" required />
							</div>
							<div>
								<input type=password class="passwordCheck" placeholder="PASSWORD 확인"
									required />
							</div>
							<div>
								<input type="password" placeholder="현재 PASSWORD"
									name="userPassword" class="userPassword" required />
							</div>
							<div class="editButtonBox">
								<div>
									<button type="submit" class="editBtn">Save</button>
									<button type="button" class="editCancel"
										onclick="location.href='/cancelUpdate'">Cancel</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let passwordCheck = false;
		let regPasswordCheck = false;
		let passwordSameCheck = false;
	
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
		
		$(".changePassword").keyup(() => {
			const regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,14}$/;
			
			if(regExp.test($(".changePassword").val())){
				$(".changePassword").css("border-bottom", "1px solid green");
				regPasswordCheck = true;
			}else{
				$(".changePassword").css("border-bottom", "1px solid red");
				regPasswordCheck = false;
			}
			if($(".changePassword").val() == $(".passwordCheck").val() && $(".changePassword").val() != ""){
				$(".passwordCheck").css("border-bottom", "1px solid green");
				passwordSameCheck = true;
			}else{
				$(".passwordCheck").css("border-bottom", "1px solid red");
				passwordSameCheck = false;
			}
		});

		$(".passwordCheck").keyup(() => {
			if($(".changePassword").val() == $(".passwordCheck").val() && $(".changePassword").val() != ""){
				$(".passwordCheck").css("border-bottom", "1px solid green");
				passwordSameCheck = true;
			}else{
				$(".passwordCheck").css("border-bottom", "1px solid red");
				passwordSameCheck = false;
			}
		});
		
		function validate(){
			if(!regPasswordCheck) alert("패스워드 형식을 확인해주세요. (알파벳/숫자/특수문자 포함 8~14자)");
			else if(!passwordSameCheck) alert("변경 할 패스워드가 다릅니다.");
			else if(!passwordCheck) alert("변경 전 패스워드가 다릅니다.")
			return regPasswordCheck && passwordSameCheck && passwordCheck;
		}
	</script>
</body>
</html>