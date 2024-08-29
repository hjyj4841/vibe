<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<li><a href="/playListRankingOnAgeGroup?ageGroup=20">Age Ranking</a></li>
		<li><a href="/playListRankingOnGender?userGender=male">Gender Ranking</a></li>
	</ul>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		  var btns = document.querySelectorAll(".rankingHead a");

		  btns.forEach(function (btn) {
		    btn.addEventListener("click", function (e) {
		      e.preventDefault();  // 기본 링크 동작 방지

		      btns.forEach(function (b) {
		        b.classList.remove("active");
		        b.classList.remove("age-ranking");
		        b.classList.remove("gender-ranking");
		      });

		      btn.classList.add("active");

		      // href 속성을 기반으로 특정 색상 클래스를 추가
		      if (btn.getAttribute("href").includes("ageGroup=20")) {
		        btn.classList.add("age-ranking");
		      } else if (btn.getAttribute("href").includes("userGender=male")) {
		        btn.classList.add("gender-ranking");
		      }

		      // Active Class 설정 후 해당 URL로 Redirection
		      window.location.href = btn.getAttribute("href");
		    });
		  });

		  // 선택적으로 현재 URL을 기반으로 활성 링크를 설정
		  var currentUrl = window.location.pathname + window.location.search;
		  btns.forEach(function (btn) {
		    if (btn.getAttribute("href") === currentUrl || 
		        (currentUrl === '/' && btn.getAttribute("href") === '/')) {
		      btn.classList.add("active");

		      // href 속성을 기반으로 특정 색상 클래스를 추가
		      if (btn.getAttribute("href").includes("ageGroup=20")) {
		        btn.classList.add("age-ranking");
		      } else if (btn.getAttribute("href").includes("userGender=male")) {
		        btn.classList.add("gender-ranking");
		      }
		    }
		  });
		});
	</script>
</body>
</html>
