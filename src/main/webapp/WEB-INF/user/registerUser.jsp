<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/register.css">
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="registerBox">
				<h1>Create Account</h1>
				<p>your email for registration</p>
				<form action="registerUser" method="post" onsubmit="return validate()">
					<div class="registerTop">
						<div class="registerLeft">
							<div>
								<div class="emailBox">
									<input type="text" name="userEmail" placeholder="Email" id="userEmail" required>
									<input type="button" value="Check" id="emailCheck">
								</div>
							</div>
							<div><input type="password" name="userPassword" placeholder="Password" id="userPassword" required></div>
							<div><input type="password" placeholder="Password Check" id="passwordCheck" required></div>
							<div>
								<div class="nicknameBox">
									<input type="text" name="userNickname" placeholder="Nickname" id="userNickname" maxlength="30" required>
									<input type="button" value="Check" id="nicknameCheck">
								</div>
							</div>
						</div>
						<div class="registerRight">
							<div>
								<h3>Gender</h3>
								<div class="genderSelect">
									<input type="radio" name="userGender" value="male" id="male" checked> 
									<label for="male">Male</label>
									<input type="radio" name="userGender" value="female" id="female"> 
									<label for="female">Female</label>
									<input type="radio" name="userGender" value="nonbinary" id="nonbinary"> 
									<label for="nonbinary">Nonbinary</label>
								</div>
								<div><input type="date" name="birthDay" data-placeholder="Date of Birth" max="9999-12-31" required></div>
								<div><input type="text" name="userPhone" placeholder="PhoneNum : 000-0000-0000" id="userPhone" maxlength="13" required></div>
							</div>
						</div>
					</div>
					<input type="submit" value="SIGN UP">
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="./js/userRegister.js"></script>
	<script>
		if('${registerMsg}' != '') alert('${registerMsg}');
	</script>
</body>
</html>