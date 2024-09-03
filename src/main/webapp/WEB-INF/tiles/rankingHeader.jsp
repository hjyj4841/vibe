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
	const url = new URL(location.href);
	const pathname = url.pathname;
	const search = pathname + url.search;
	const btns = document.querySelectorAll(".rankingHead a");

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
