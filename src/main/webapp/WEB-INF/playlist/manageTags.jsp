<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태그 관리</title>
<link rel="stylesheet" href="/css/reset.css" />
<link rel="stylesheet" href="/css/mypage.css" />
<link rel="stylesheet" href="/css/manageTags.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="../tiles/header.jsp"></jsp:include>
	<div class="container">
		<div class="con">
			<div class="mypageBox">
				<div class="myLeft">
					<jsp:include page="../tiles/mypageLeft.jsp"></jsp:include>
				</div>

				<div class="myRight">
					<div class="tag-list-wrapper">
						<h1>Tag Management</h1>

						<!-- 태그 추가 폼 -->
						<div class="form-tag-section">
							<div class="form-tag-section-addTagForm">
								<form id="addTagForm"
									action="${pageContext.request.contextPath}/playlist/addTag"
									method="post">
									<input type="hidden" name="plCode" value="${playlistCode}">
									<h2>New Tags</h2>
									<input type="text" id="tags" name="newTag"
										placeholder="Type your new Tag" required />
									<button type="submit">Add</button>
								</form>
							</div>
						</div>

						<!-- 태그 삭제 폼 -->
						<div class="table-section">
							<h2>Remove Tags</h2>
							<form id="deleteTagForm"
								action="${pageContext.request.contextPath}/playlist/deleteTags"
								method="post">
								<input type="hidden" name="plCode" value="${playlistCode}" />
								<table>
									<thead>
											<td class="tags-column">Tags</td>
									</thead>
									<tbody>
										<c:forEach var="playlistTag" items="${existingTags}">
											<tr>
												<td class="radioCheckBox"><input type="checkbox"
													name="tagCodes[]" value="${playlistTag.tag.tagCode}"
													id="checkbox-${playlistTag.tag.tagCode}" /> <label
													for="checkbox-${playlistTag.tag.tagCode}"></label></td>
												<td class="deleteTagList">${playlistTag.tag.tagName}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<button type="submit">Delete</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="./js/manageTag.js"></script>
</body>
</html>
