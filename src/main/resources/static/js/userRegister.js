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
				$("#userEmail").css("background-color", "#E69E8F");
				emailCheck = false;
			}else if($("#userEmail").val() === ""){
				alert("이메일을 입력해주세요.");
				$("#userEmail").css("background-color", "#E69E8F");
				emailCheck = false;
			}else if(!regEmailCheck){
				alert("이메일 형식으로 입력해주세요.");
				$("#userEmail").css("background-color", "#E69E8F");
				emailCheck = false;
			}else{
				alert("사용가능한 이메일 입니다.");
				emailCheck = true;
				$("#userEmail").css("background-color", "#AEEBB8");
				$("#emailCheck").val("✔")
					.css({"color": "black",
						"font-size": "1.3rem"});
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
				$("#userNickname").css("background-color", "#E69E8F");
				nicknameCheck = false;
			} else if($("#userNickname").val() === ""){
				alert("닉네임을 입력해주세요.");
				$("#userNickname").css("background-color", "#E69E8F");
				nicknameCheck = false;
			}else{
				alert("사용가능한 닉네임 입니다.");
				nicknameCheck = true;
				$("#userNickname").css("background-color", "#AEEBB8");
				$("#nicknameCheck").val("✔")
					.css({"color": "black",
						"font-size": "1.3rem"});
			}
		}
	});
});

$("#userEmail").keyup(() => {
	emailCheck = false;
	const regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	$("#emailCheck").val("Check")
		.css({"color": "#b6b6b6",
			"font-size": "0.8rem"});
	if(regExp.test($("#userEmail").val())){
		regEmailCheck = true;
		$("#userEmail").css("background-color", "#AEEBB8");
	}else{
		regEmailCheck = false;
		$("#userEmail").css("background-color", "#E69E8F");
	}

});
$("#userNickname").keyup(() => {
	nicknameCheck = false;
	$("#nicknameCheck").val("Check")
		.css({"color": "#b6b6b6",
			"font-size": "0.8rem"});
});

$("#userPassword").keyup(() => {
	const regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,14}$/;
	
	if(regExp.test($("#userPassword").val())){
		$("#userPassword").css("background-color", "#AEEBB8");
		regPasswordCheck = true;
	}else{
		$("#userPassword").css("background-color", "#E69E8F");
		regPasswordCheck = false;
	}
	if($("#userPassword").val() == $("#passwordCheck").val() && $("#userPassword").val() != ""){
		$("#passwordCheck").css("background-color", "#AEEBB8");
		passwordSameCheck = true;
	}else{
		$("#passwordCheck").css("background-color", "#E69E8F");
		passwordSameCheck = false;
	}
});

$("#passwordCheck").keyup(() => {
	if($("#userPassword").val() == $("#passwordCheck").val() && $("#userPassword").val() != ""){
		$("#passwordCheck").css("background-color", "#AEEBB8");
		passwordSameCheck = true;
	}else{
		$("#passwordCheck").css("background-color", "#E69E8F");
		passwordSameCheck = false;
	}
});

$("#userPhone").keyup(() => {
	const regExp = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;
	
	$("#userPhone").val($("#userPhone").val().replace(/[^0-9]/gi, ""));
	$("#userPhone").val($("#userPhone").val().replace(/[^0-9]/gi, "").replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
	
	if(regExp.test($("#userPhone").val())){
		$("#userPhone").css("background-color", "#AEEBB8");
		phoneCheck = true;
	}else{
		$("#userPhone").css("background-color", "#E69E8F");
		phoneCheck = false;
	}
});

function validate(){
	if(!emailCheck) alert("이메일 체크를 진행해주세요.");
	else if(!nicknameCheck) alert("닉네임 체크를 진행해주세요.");
	else if(!regEmailCheck) alert("이메일형식을 확인해주세요.");
	else if(!regPasswordCheck) alert("패스워드 형식을 확인해주세요. (알파벳/숫자/특수문자 포함 8~14자)");
	else if(!passwordSameCheck) alert("패스워드가 올바르지 않습니다.");
	else if(!phoneCheck) alert("전화번호 형식을 확인해주세요.");
	else return true;
}