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
   <h1>Playlists Likes</h1>
   <c:choose>
     <c:when test="${not empty playlists}">
       <table border="1">
         <thead>
           <tr>
             <th>Playlist Code</th>
             <th>Playlist Name</th>
             <th>Likes Count</th>
           </tr>
         </thead>
         <tbody>
            <c:forEach var="playlist items="$>
              <tr>
                <td><c:out value="${playlist.plCode}" /></td>
                <td><c:out value="${playlist.plName}" /></td>
                <td><c:out value="${playlist.likeCount}" /></td>
              </tr>
            </c:forEach>
         </tbody>
       </table>
     </c:when>
   </c:choose>
</body>
</html>