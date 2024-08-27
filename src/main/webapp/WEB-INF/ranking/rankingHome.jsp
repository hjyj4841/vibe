<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/rankingHome.css" />
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<jsp:include page="../tiles/rankingHeader.jsp"></jsp:include>
	<div id="content">
		<c:choose>
			<c:when test="${param.select == 'like' }">
				<jsp:include page="likeranking.jsp" />
			</c:when>
			<c:when test="${param.select == 'tag' }">
				<jsp:include page="searchTagRanking.jsp" />
			</c:when>
			<c:when test="${param.select == 'month' }">
				<jsp:include page="playListRankingOnMonth.jsp"/>
			</c:when>
			<c:when test="${param.select == 'age' }">
				<jsp:include page="playListRankingOnAgeGroup.jsp"/>
			</c:when>
			<c:when test="${param.select == 'gender'}">
				<jsp:include page="playListRankingOnGender.jsp"/>
			</c:when>
		</c:choose>
	</div>
</body>
</html>