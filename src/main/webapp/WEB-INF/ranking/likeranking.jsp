<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Like Ranking</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="./css/likeranking.css" />
</head>
<body>
    <h1>Ranking</h1>
    <div class="size-test">Like Ranking</div>
    <div id="rankingList">
        <c:forEach var="playlist" items="${likeranking}">
            <section class="listRank">
                <img class="listImg" src="${playlist.plImg}" alt="Playlist Image" />
                <div class="listRankDesc">
                    <img class="listMiniImg" src="${playlist.plImg}" alt="Mini Playlist Image" />
                    <div class="listRankText">
                        <div class="size-test2"><p>${playlist.plTitle}</p></div>
                        <p>${playlist.user.userNickname}</p>
                    </div>
                </div>
            </section>
        </c:forEach>
    </div>
</body>
</html>