<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<!-- footer -->
<footer>
  <p>Challenge to make Best PlayList</p>
  <nav id="footernav">
    <sec:authorize access="!isAuthenticated()">
      <a href="login" class="signIn">Sign In</a>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
      <a href="mypage" class="signIn">my Page</a>
    </sec:authorize>
    <a href="likeranking" class="ranking">Ranking</a>
  </nav>
</footer>
