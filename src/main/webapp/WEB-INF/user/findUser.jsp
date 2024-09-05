<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VibeMaster</title>
<link rel="icon" href="/imgs/logo/logoB_small.png">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/findUser.css" />
</head>
<body>
	<div>
		<jsp:include page="../tiles/header.jsp"></jsp:include>
		<div class="container">
			<h1>Find your account</h1>
			<div>
				<div class="emailFind">
					<h2>Find your email</h2>
					<form class="emailFrm">
						<div>
							<input type="date" id="eBirthDay" name="birthDay" data-placeholder="Date of Birth" max="9999-12-31" required>
						</div>
						<div>
							<input type="text" id="eUserPhone" name="userPhone" placeholder="PhoneNum" maxlength="13" required>
						</div>
						<div>
							<button type="button" onclick="findEmail()">find email</button>
						</div>
					</form>
				</div>
				<div class="passwordFind">
					<h2>Find your password</h2>
					<form class="passwordFrm">
						<div>
							<input type="text" id="userEmail" name="userEmail" placeholder="Email">
						</div>
						<div>
							<input type="date" id="pBirthDay" name="birthDay" data-placeholder="Date of Birth" max="9999-12-31" required>
						</div>
						<div>
							<input type="text" id="pUserPhone" name="userPhone" placeholder="PhoneNum" maxlength="13" required>
						</div>
						<div>
							<button type="button" onclick="findPassword()">find password</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		let ePhoneCheck = false;
		let pPhoneCheck = false;
		let regEmailCheck = false;
		regPasswordCheck = false;
		passwordSameCheck = false;
		
		$('#eUserPhone').keyup(() => {
			const regExp = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;
			
			$("#eUserPhone").val($("#eUserPhone").val().replace(/[^0-9]/gi, ""));
			$("#eUserPhone").val($("#eUserPhone").val().replace(/[^0-9]/gi, "").replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
			
			if(regExp.test($("#eUserPhone").val())){
				$("#eUserPhone").css("border-bottom", "1px solid green");
				ePhoneCheck = true;
			}else{
				$("#eUserPhone").css("border-bottom", "1px solid red");
				ePhoneCheck = false;
			}
		});
		
		$('#pUserPhone').keyup(() => {
			const regExp = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;
			
			$("#pUserPhone").val($("#pUserPhone").val().replace(/[^0-9]/gi, ""));
			$("#pUserPhone").val($("#pUserPhone").val().replace(/[^0-9]/gi, "").replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
			
			if(regExp.test($("#pUserPhone").val())){
				$("#pUserPhone").css("border-bottom", "1px solid green");
				pPhoneCheck = true;
			}else{
				$("#pUserPhone").css("border-bottom", "1px solid red");
				pPhoneCheck = false;
			}
		});
		
		$("#userEmail").keyup(() => {
			emailCheck = false;
			const regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			
			if(regExp.test($("#userEmail").val())){
				regEmailCheck = true;
				$("#userEmail").css("border-bottom", "1px solid green");
			}else{
				regEmailCheck = false;
				$("#userEmail").css("border-bottom", "1px solid red");
			}

		});
		
		function findEmail(){
			if($('#eBirthDay').val() === '') alert('생년월일을 입력해주세요.');
			else if($('#eUserPhone').val() === '') alert('전화번호를 입력해주세요.');
			else if(!ePhoneCheck) alert('전화번호 형식을 확인해주세요.');
			else{
				$.ajax({
					type: 'post',
					url: '/findUser',
					data: $('.emailFrm').serialize(),
					success: function(data){
						if(data === '') alert('회원이 존재하지 않습니다.');
						else alert('회원의 이메일은 ' + data + '입니다.');
					}
				});
			}
		}
		const changePwdForm = 
			'<h2>changePassword</h2>' +
			'<form class="changePassowrdFrm">' +
				'<div>' +
					'<input type="password" id="userPassword" name="userPassword" placeholder="Password" required>' +
				'</div>' +
				'<div>' +
					'<input type="password" id="passwordCheck" placeholder="Password Check" required>' +
				'</div>' +
				'<div>' +
					'<button type="button" onclick="changePassword()">change Password</button>' +
				'</div>' +
			'</form>';
			
		function findPassword(){
			if($('#userEmail').val() === '') alert('이메일을 입력해주세요.');
			else if(!regEmailCheck) alert('이메일 형식을 확인해주세요.');
			else if($('#pBirthDay').val() === '') alert('생년월일을 입력해주세요.');
			else if($('#pUserPhone').val() === '') alert('전화번호를 입력해주세요.');
			else if(!pPhoneCheck) alert('전화번호 형식을 확인해주세요.');
			else{
				$.ajax({
					type: 'post',
					url: '/findUser',
					data: $('.passwordFrm').serialize(),
					success: function(userEmail){
						if(userEmail === '') {
							alert('회원이 존재하지 않습니다.');
						}
						else {
							alert('회원이 확인되었습니다. 비밀번호를 변경해주세요.');
							
							$('.passwordFind').append(changePwdForm);
						}
						
						$("#userPassword").keyup(() => {
							const regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,14}$/;
							
							if(regExp.test($("#userPassword").val())){
								$("#userPassword").css("border-bottom", "1px solid green");
								regPasswordCheck = true;
							}else{
								$("#userPassword").css("border-bottom", "1px solid red");
								regPasswordCheck = false;
							}
							if($("#userPassword").val() == $("#passwordCheck").val() && $("#userPassword").val() != ""){
								$("#passwordCheck").css("border-bottom", "1px solid green");
								passwordSameCheck = true;
							}else{
								$("#passwordCheck").css("border-bottom", "1px solid red");
								passwordSameCheck = false;
							}
						});
		
						$("#passwordCheck").keyup(() => {
							if($("#userPassword").val() == $("#passwordCheck").val() && $("#userPassword").val() != ""){
								$("#passwordCheck").css("border-bottom", "1px solid green");
								passwordSameCheck = true;
							}else{
								$("#passwordCheck").css("border-bottom", "1px solid red");
								passwordSameCheck = false;
							}
					});
				
					
					}
				});
			}
		}
		
		function changePassword(){
			if(!regPasswordCheck) alert("패스워드 형식을 확인해주세요. (알파벳/숫자/특수문자 포함 8~14자)");
			else if(!passwordSameCheck) alert("패스워드가 다릅니다.");
			else{
				$.ajax({
					type: 'post',
					url: '/updateUserPWD',
					data: {
						userEmail: $('#userEmail').val(),
						userPassword: $('#userPassword').val()
					},
					success: function(){
						alert('비밀번호가 변경되었습니다.');
						window.location.href = '/login';
					}
				});
			}
		}
		
	</script>
</body>
</html>