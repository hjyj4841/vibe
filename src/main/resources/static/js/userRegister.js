let emailCheck = false;
let nicknameCheck = false;
let regEmailCheck = false;
let regPasswordCheck = false;
let passwordSameCheck = false;
let phoneCheck = false;

$("#emailCheck").click(() => {
	const regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	$.ajax({
		type: "post",
		url: "/emailCheck",
		data: {
			userEmail: $("#userEmail").val()
		},
		success: function(checkOk){
			if(!checkOk) {
				alert("중복된 이메일 입니다.");
				$("#userEmail").css("border-bottom", "1px solid red");
				emailCheck = false;
			}else if($("#userEmail").val() === ""){
				alert("이메일을 입력해주세요.");
				$("#userEmail").css("border-bottom", "1px solid red");
				emailCheck = false;
			}else if(!regEmailCheck){
				alert("이메일 형식으로 입력해주세요.");
				$("#userEmail").css("border-bottom", "1px solid red");
				emailCheck = false;
			}else{
				alert("사용가능한 이메일 입니다.");
				emailCheck = true;
				$("#userEmail").css("border-bottom", "1px solid green");
				$("#emailCheck").val("✓")
					.css({"color": "black",
						"font-size": "1rem"});
			}
		}
	});
});

$("#nicknameCheck").click(() => {
	$.ajax({
		type: "post",
		url: "/nicknameCheck",
		data: {
			userNickname: $("#userNickname").val()
		},
		success: function(checkOk){
			if(!checkOk){
				alert("중복된 닉네임 입니다.");
				$("#userNickname").css("border-bottom", "1px solid red");
				nicknameCheck = false;
			} else if($("#userNickname").val() === ""){
				alert("닉네임을 입력해주세요.");
				$("#userNickname").css("border-bottom", "1px solid red");
				nicknameCheck = false;
			}else{
				alert("사용가능한 닉네임 입니다.");
				nicknameCheck = true;
				$("#userNickname").css("border-bottom", "1px solid green");
				$("#nicknameCheck").val("✓")
					.css({"color": "black",
						"font-size": "1rem"});
			}
		}
	});
});

$("#userEmail").keyup(() => {
	emailCheck = false;
	const regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	$("#emailCheck").val("Check")
		.css({"color": "#787775",
			"font-size": "0.8rem"});
	if(regExp.test($("#userEmail").val())){
		regEmailCheck = true;
		$("#userEmail").css("border-bottom", "1px solid green");
	}else{
		regEmailCheck = false;
		$("#userEmail").css("border-bottom", "1px solid red");
	}

});
$("#userNickname").keyup(() => {
	nicknameCheck = false;
	$("#nicknameCheck").val("Check")
		.css({"color": "#787775",
			"font-size": "0.8rem"});
});

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

$("#userPhone").keyup(() => {
	const regExp = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;
	
	$("#userPhone").val($("#userPhone").val().replace(/[^0-9]/gi, ""));
	$("#userPhone").val($("#userPhone").val().replace(/[^0-9]/gi, "").replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
	
	if(regExp.test($("#userPhone").val())){
		$("#userPhone").css("border-bottom", "1px solid green");
		phoneCheck = true;
	}else{
		$("#userPhone").css("border-bottom", "1px solid red");
		phoneCheck = false;
	}
});

function validate(){
	if(!emailCheck) alert("이메일 체크를 진행해주세요.");
	else if(!nicknameCheck) alert("닉네임 체크를 진행해주세요.");
	else if(!regEmailCheck) alert("이메일형식을 확인해주세요.");
	else if(!regPasswordCheck) alert("패스워드 형식을 확인해주세요. (알파벳/숫자/특수문자 포함 8~14자)");
	else if(!passwordSameCheck) alert("패스워드가 다릅니다.");
	else if(!phoneCheck) alert("전화번호 형식을 확인해주세요.");
	return emailCheck && nicknameCheck && regEmailCheck 
	&& regPasswordCheck && passwordSameCheck && phoneCheck;
}