<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>회원 정보 수정</h1>
	<form action="updateUser" method="post" onsubmit="return validate()">
		<table>
			<tr>
				<td>비밀번호 수정 :</td>
				<td><input type=password name="userPassword"
					required></td>
			</tr>
			<tr>
				<td>닉네임 수정 :</td>
				<td><input type=text name="userNickname" class="nickname"
					value="${user.userNickname }">
					<button type="button" id="nicknameCheck">중복조회</button>
					</td>
			</tr>
			<tr>
				<td>전화번호 수정 :</td>
				<td><input type=text name="userPhone"
					value="${user.userPhone }"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button type="submit">수정하기</button>
				</td>
			</tr>
		</table>
	</form>
	<script>
		let nicknameCheck = true;
		
		$("#nicknameCheck").click(() => {
			$.ajax({
				type: "post",
				url: "/nicknameUpdate",
				data: {
					userNickname: $(".nickname").val()
				},
				success: function(check){
					if(check) {
						if($(".nickname").val() != ''){
							alert("사용가능");
							nicknameCheck = true;
						} else{
							alert("사용불가");
							nicknameCheck = false;
						}
					} else {
						alert("사용불가");
						nicknameCheck = false;
					}
				}
			});
		});
		
		function validate(){
			if(!nicknameCheck) alert("닉네임 중복확인 해주세요");
			return nicknameCheck;
		}
	</script>
</body>
</html>