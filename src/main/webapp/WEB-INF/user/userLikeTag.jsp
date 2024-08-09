<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요한 태그</title>
</head>
<body>
    <h1>내가 좋아요한 태그</h1>
    <ul>
        <c:choose>
            <c:when test="${not empty likeTagList}">
                <c:forEach var="tag" items="${likeTagList}">
                    <li>${tag.tagName} (좋아요 수: ${tag.tagCount})</li>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <li>좋아요한 태그가 없습니다.</li>
            </c:otherwise>
        </c:choose>
    </ul>
</body>
</html>