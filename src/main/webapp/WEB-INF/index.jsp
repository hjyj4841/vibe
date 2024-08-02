<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <!-- 플레이리스트 -->
    <form action="/" method="post">
      <table border="1">
        <tr>
          <th>플리 코드</th>
          <th>제목명</th>
          <th>이미지</th>
          <th>날짜</th>
          <th>공개여부</th>
          <th>이메일</th>
        </tr>
        <tr>
          <td>${playlist.plCode}</td>
          <td>${playlist.plTitle}</td>
          <td>${playlist.plImg}</td>
          <td>${playlist.plDate}</td>
          <td>${playlist.plPublicYn}</td>
          <td>${playlist.userEmail}</td>
          <!-- <input type="email" id="userEmail" name="userEmail" required> -->
        </tr>
      </table>
    </form>

    <!-- 회원 관리 -->
    <ul>
      <c:if test="${user == null}">
        <li><a href="login">로그인</a></li>
        <li><a href="register">회원가입</a></li>
      </c:if>
      <c:if test="${user != null}">
        <li><a href="mypage">마이페이지</a></li>
        <li><a href="logout">로그아웃</a></li>
      </c:if>
      <li><a href="artist">api 참고 테스트</a></li>
    </ul>

    <!-- 플레이리스트 생성 -->
    <h1>플레이리스트 생성</h1>
    <form action="/createPlaylist" method="post">
      <input type="hidden" name="user_email" value="agrigs9@opensource.org" />
      <label for="pl_title">플레이리스트 제목:</label>
      <input type="text" id="pl_title" name="pl_title" required />
      <button type="submit">플레이리스트 생성</button>
    </form>
  </body>
</html>
