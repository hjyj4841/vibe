<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/reset.css" />
<link rel="stylesheet" href="/css/style.css" />
<script src="https://kit.fontawesome.com/df04184d5c.js"
	crossorigin="anonymous"></script>
<title>VibeMaster</title>
</head>
<body>
	<jsp:include page="tiles/header.jsp"></jsp:include>
	<section id="mainbanner">
		<div id="mainchant">
			<p id="chant">Vibe that I want to BE</p>
			<p id="maintitle">VIBEMASTER</p>
		</div>
		<nav id="mainnav">
			<a href="" id="signIn">Sign In</a><a href="" id="ranking">Ranking</a>
		</nav>
	</section>
	<section id="listRank1">
		<div id="listRank1backimg">
			<img src="/imgs/playlistimg/list1.jpg" alt="" />
		</div>

		<div id="listRank1Miniimg">
			<img src="/imgs/playlistimg/list1.jpg" alt="" />
		</div>
		</div>

		<div id="listRank1Text">
			<p>개쩌는 힙합클럽 MIX</p>
			<p>귤까먹는귤귤이</p>
		</div>
		<div id="listRank1Icon">
			<a href=""><i class="fa-solid fa-forward"></i></a>
		</div>
	</section>
	<section id="listRank2">
		<div id="listRank2backimg">
			<img src="/imgs/playlistimg/list2.jpg" alt="" />
		</div>

		<div id="listRank2Miniimg">
			<img src="/imgs/playlistimg/list2.jpg" alt="" />
		</div>
		</div>

		<div id="listRank2Text">
			<p>nowitzki</p>
			<p>beenzino</p>
		</div>
		<div id="listRank2Icon">
			<a href=""><i class="fa-solid fa-forward"></i></a>
		</div>
	</section>
	<section id="listRank3">
		<div id="listRank3backimg">
			<img src="/imgs/playlistimg/list3.jpg" alt="" />
		</div>

		<div id="listRank3Miniimg">
			<img src="/imgs/playlistimg/list3.jpg" alt="" />
		</div>
		</div>

		<div id="listRank3Text">
			<p>24:26</p>
			<p>beenzino</p>
		</div>
		<div id="listRank3Icon">
			<a href=""><i class="fa-solid fa-forward"></i></a>
		</div>
	</section>

	<jsp:include page="tiles/footer.jsp"></jsp:include>
</body>
</html>
