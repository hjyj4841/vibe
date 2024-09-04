<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="./css/rankingHeader.css" />
</head>
<body>
	<ul class="rankingHead">
		<li><a href="/likeranking">Like Ranking</a></li>
		<sec:authorize access="!isAuthenticated()">
			<li><a href="/playListRankingOnAgeGroup?ageGroup=20">Age Ranking</a></li>
			<li><a href="/playListRankingOnGender?userGender=male">Gender Ranking</a></li>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="user" />
			<script>
				const curDate = new Date();
				const userBirth = new Date('${user.userBirth.getYear()}-${user.userBirth.getMonth()+1}-${user.userBirth.getDate()}');
				const ageClass = Math.abs(curDate.getFullYear() - userBirth.getFullYear());
				let ageGroup;
				
				if(10 <= ageClass && ageClass < 20){
					ageGroup = 10;
				}else if(20 <= ageClass && ageClass < 30){
					ageGroup = 20;
				}else if(30 <= ageClass && ageClass < 40){
					ageGroup = 30;
				}else if(40 <= ageClass && ageClass < 50){
					ageGroup = 40;
				}else if(50 <= ageClass && ageClass < 60){
					ageGroup = 50;
				}else{
					ageGroup = 'etc';
				}
			</script>
			<li><a href="" id="ageMove">Age Ranking</a></li>
			<li><a href="/playListRankingOnGender?userGender=${user.userGender }">Gender Ranking</a></li>
		</sec:authorize>
	</ul>
	<script>
	const url = new URL(location.href);
	const pathname = url.pathname;
	const search = pathname + url.search;
	const btns = document.querySelectorAll(".rankingHead a");
	
	$('#ageMove').click((e) => {
		e.preventDefault();
		location.href = '/playListRankingOnAgeGroup?ageGroup=' + ageGroup;
	});

	document.addEventListener("DOMContentLoaded", function () {
		const links = document.querySelectorAll(".ageLink a");
	
		btns.forEach((btn) => {
			if(pathname === btn.getAttribute("href").split("?")[0]) {
				btn.classList.add("active");
			}
		})
		

		if(url.search !== "") {
			links.forEach((link) => {
				if(search === link.getAttribute("href")) {
					link.style.color = "red";
				}
			})
		}
	});

	</script>
</body>
</html>
