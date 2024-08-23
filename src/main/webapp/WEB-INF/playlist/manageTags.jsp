<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 관리</title>
    <link rel="stylesheet" href="./css/style.css" />
	<link rel="stylesheet" href="./css/reset.css" />
	<link rel="stylesheet" href="/css/manageTags.css" />
</head>
<body>
    <jsp:include page="../tiles/header.jsp"></jsp:include>
    <div class="container">
        <h1>Tag Management</h1>

        <!-- 태그 추가 폼 -->
        <div class="form-tag-section">
            <form action="${pageContext.request.contextPath}/playlist/addTag" method="post">
                <input type="hidden" name="plCode" value="${playlistCode}">
                <h2>New Tags</h2>
                <input type="text" id="tags" name="newTag" placeholder="Type your new Tag" required />
                <button type="submit">Add Tag</button>
            </form>
        </div>
        
        <!-- 에러 메시지 표시 -->
        <c:if test="${not empty error}">
            <p style="color: red;">${error}</p>
        </c:if>

        <!-- 태그 삭제 폼 -->
        <div class="table-section">
            <h2>Remove Tags</h2>
            <form action="${pageContext.request.contextPath}/playlist/deleteTags" method="post">
                <input type="hidden" name="plCode" value="${playlistCode}" />
                <table>
                    <thead>
                        <tr>
                            <th>Tags</th>
                            <th><th><th><th><th><th><th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="playlistTag" items="${existingTags}">
                            <tr>
                                <td>${playlistTag.tag.tagName}</td>
                                <th><th><th><th><th><th>
                                <td>
                                    <input type="checkbox" name="tagCodes[]" value="${playlistTag.tag.tagCode}" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <button type="submit">Delete</button>
            </form>
        </div>
    </div>
    <script src="./js/manageTag.js"></script>
</body>
</html>