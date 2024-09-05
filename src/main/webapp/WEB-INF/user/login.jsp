<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/login.css">
<link rel="icon" href="/imgs/logo/logoB_small.png">
<title>VibeMaster</title>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="loginBox">
				<div class="loginBoxLeft">
					<h1>Sign In</h1>
					<p>your account</p>
					<form action="/login" method="post">
						<div><input type="text" name="username" placeholder="Email" id="userEmail"></div>
						<div><input type="password" name="password" placeholder="Password" id="userPassword"></div>
						<div><a href="/findUser">Forgot your Email or Password?</a></div>
						<div><input type="submit" value="SIGN IN"></div>
					</form>
				</div>
				<div class="loginBoxRight">
					<h1>Sign Up</h1>
					<p>Enter your personal details and start digging with us</p>
					<a href="registerUser">SIGN UP</a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		if('${msg }' != '') alert('${msg}');
	</script>
</body>
</html>