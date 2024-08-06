<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/reset.css" />
<link rel="stylesheet" href="/css/register.css">
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="registerBox">
				<h1>Create Account</h1>
				<p>your email for registration</p>
				<form action="registerUser" method="post">
					<div class="registerTop">
						<div class="registerLeft">
							<div><input type="text" name="userEmail" placeholder="Email" required></div>
							<div><input type="password" name="userPassword" placeholder="Password" required></div>
							<div><input type="text" name="userNickname" placeholder="Nickname" required></div>
						</div>
						<div class="registerRight">
							<div class="genderSelect">
								<input type="radio" name="userGender" value="male" id="male" checked> <label for="male">Male</label>
								<input type="radio" name="userGender" value="female" id="female"> <label for="female">Female</label>
								<input type="radio" name="userGender" value="nonbinary" id="nonbinary"> <label for="nonbinary">Nonbinary</label>
							</div>
							<div><input type="date" name="birthDay" required></div>
							<div><input type="text" name="userPhone" placeholder="PhoneNum : 000-0000-0000" required></div>
						</div>
					</div>
					<input type="submit" value="회원가입">
				</form>
			</div>
		</div>
		<jsp:include page="../tiles/footer.jsp"></jsp:include>
	</div>
</body>
</html>