<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<!-- footer -->
	<footer>
		<p>Challenge to make Best PlayList</p>
		<nav id="footernav">
			<c:if test="${user == null }">
				<a href="login" class="signIn">Sign In</a>
			</c:if>
			<c:if test="${user != null }">
				<a href="mypage" class="signIn">my Page</a>
			</c:if>
			
			<!-- 랭킹 조회 -->
			<a href="likeranking" class="ranking">Ranking</a>
		</nav>
	</footer>