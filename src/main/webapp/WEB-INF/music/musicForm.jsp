<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>검색하기</title>
  </head>
  <body>
    <h1>검색하기</h1>
    <form action="addMusic" method="post">
      <label for="musicName">아티스트, 곡 등을 검색해보세요.</label>
      <input type="text" id="musicName" name="musicName" required />
      <button type="submit">검색</button>
    </form>
  </body>
</html>
