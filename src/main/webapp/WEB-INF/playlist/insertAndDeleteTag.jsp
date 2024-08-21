<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 관리</title>
</head>
<body>
    <h1>플레이리스트 태그 관리</h1>
    
    <!-- 태그 추가 폼 -->
    <form action="${pageContext.request.contextPath}/playlist/addTag" method="post">
        <input type="hidden" name="plCode" value="${playlistCode}">
        <h2>새 태그 추가</h2>
        <input type="text" name="newTag" placeholder="새 태그 입력" required />
        <button type="submit">태그 추가</button>
    </form>

    <h2>삭제할 태그 선택</h2>
    
    <form action="${pageContext.request.contextPath}/playlist/deleteTags" method="post">
    <input type="hidden" name="plCode" value="${playlistCode}" />
    
    <table>
        <tbody>
            <c:forEach var="playlistTag" items="${existingTags}">
                <tr>
                    <td>${playlistTag.tag.tagName}</td>
                    <td>
                        <input type="checkbox" name="tagCodes[]" value="${playlistTag.tag.tagCode}" />
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <button type="submit">삭제</button>
</form>


</body>
</html>
