<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VibeMaster</title>
<link rel="icon" href="/imgs/logo/logoB_small.png">
</head>
<body>

</body>
<script>
	if ('${registerMsg}' != '') {
		alert('${registerMsg}');
		location.href = '/';
	}
	if ('${pwdChange}' != ''){
		alert('${pwdChange}');
		location.href = '/';
	}
</script>
</html>