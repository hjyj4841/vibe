<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>내가 좋아한 리스트</h1>
    <table>
       <!-- 내가 좋아요한 플리 조회 -->
       <tr>
         <th>플리 이미지</th>
         <th>플리 제목</th>
         <th>작성자 이미지</th>
         <th>작성자 닉네임</th>
         <th>작성자 이메일</th>
       </tr>
      <c:forEach items="${list}" var="list">
         <tr>
          <td><img src="${list.playlist.plImg}"></td>
          <td>${list.playlist.plTitle}</td>
          <td><img src="${list.user.userImg}"></td>
          <td>${list.user.userNickname}</td>
          <td>${list.user.userEmail}</td>
         </tr>
       </c:forEach>
    </table>
    <script></script>
</body>
</html>