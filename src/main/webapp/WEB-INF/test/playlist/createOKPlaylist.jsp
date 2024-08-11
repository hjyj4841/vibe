<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>플레이리스트 생성 완료</title>
	<script type="text/javascript">
    	window.onload = function() {
        	alert("플레이리스트가 성공적으로 생성되었습니다!");
        	
   			// 알림창 닫고 0.1초(100ms) 후 메인 페이지로 이동. 거의 바로 이동함
        	setTimeout(function() {
            	window.location.href = "/";
        	}, 100);
   		};
    </script>
</head>
<body>
   <!-- <h1>${message}</h1> -->
   <!-- <a href="/">메인 페이지로 돌아가기</a> -->
</body>
</html>
