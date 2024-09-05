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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.9.6/tagify.min.js"></script>
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
									<c:if test="${not empty addSuccessMessage}">
										<div id="addSuccessMessage" class="alert-success">
											<c:out value="${addSuccessMessage}" />
										</div>
									</c:if>
									<c:if test="${not empty addErrorMessage}">
										<div id="addErrorMessage" class="alert-danger">
											<c:out value="${addErrorMessage}" />
										</div>
									</c:if>
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
										<tr>
											<td class="tags-column">Tags</td>
										</tr>
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
								<c:if test="${not empty deleteSuccessMessage}">
									<div id="deleteSuccessMessage" class="alert-success">
										<c:out value="${deleteSuccessMessage}" />
									</div>
								</c:if>
								<c:if test="${not empty deleteErrorMessage}">
									<div id="deleteErrorMessage" class="alert-danger">
										<c:out value="${deleteErrorMessage}" />
									</div>
								</c:if>
								<button type="submit">Delete</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="./js/manageTag.js"></script>
	<script>
		// 메시지를 자동으로 숨기는 함수
		function hideMessageAfterDelay(id, delay) {
			const messageElement = document.getElementById(id);
			if (messageElement) {
				setTimeout(() => {
					messageElement.style.display = 'none';
				}, delay);
			}
		}

		document.addEventListener('DOMContentLoaded', function() {
			// 메시지를 2초 후에 숨기도록 설정
			hideMessageAfterDelay('addSuccessMessage', 2000);
			hideMessageAfterDelay('addErrorMessage', 2000);
			hideMessageAfterDelay('deleteSuccessMessage', 2000);
			hideMessageAfterDelay('deleteErrorMessage', 2000);
		});
		
		// 태그 입력 시 특수문자 제거
        document.addEventListener('DOMContentLoaded', function() {
            const input = document.querySelector('#tags');
            const tagify = new Tagify(input, {
                maxTags: 5,
                tagTextProp: 'value' // 태그의 텍스트 값 설정
            });

            tagify.on('add', function(e){
                const tagValue = e.detail.data.value;
                const cleanedTag = tagValue.replace(/[^a-zA-Z0-9 ]+/g, '');
                if (cleanedTag !== tagValue) {
                    tagify.removeTag(e.detail.tag);
                    tagify.addTags(cleanedTag);
                    alert("특수문자는 사용할 수 없습니다.");
                }
            });
        });
	</script>
</body>
</html>
