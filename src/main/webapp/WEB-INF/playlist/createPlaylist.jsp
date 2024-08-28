<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Create Playlist</title>
    <link rel="stylesheet" href="./css/style.css" />
    <link rel="stylesheet" href="./css/reset.css" />
   
    <link rel="stylesheet" href="./css/createPlaylist.css" />
    
  </head>
  <body>
    <jsp:include page="../tiles/header.jsp"></jsp:include>

    <div class="container">
      <h1>Create Playlist</h1>

      <form
        action="createPlaylist"
        method="post"
        autocomplete="off"
        enctype="multipart/form-data"
      >
        <!-- 제목 입력 필드 -->
        <div class="title-input-container">
          <input
            type="text"
            id="plTitle"
            name="plTitle"
            class="hidden-value"
            placeholder="Type your Playlist's title"
          />
        </div>

        <!-- 이미지 미리보기 및 기본 이미지 -->
        <div class="image-preview-container">
          <img src="" style="width: 300px" id="createPlaylistImg" />
          <div class="image-controls">
            <input
              type="file"
              id="plUrl"
              name="plUrl"
              accept="image/*"
              onchange="previewImg(event)"
            />
            <button type="button" onclick="resetDefaultImg()">
              기본 이미지로
            </button>
          </div>
        </div>

        <!-- 태그 입력 필드 -->
        <div class="form-tag-section">
          <input
            type="text"
            id="tags"
            name="tags"
            placeholder="Type your Tags"
          />
        </div>

        <!-- 제출 버튼 -->
        <div class="form-submit-container">
          <button type="submit">Create Playlist</button>
        </div>
      </form>
    </div>
    <script src="./js/tag.js"></script>
  </body>
</html>

<!-- 삭제 금지! -->
<!-- 아래 코드 뭐하려고 했던 거냐면. 플레이리스트 생성 시 제목을 무조건 입력해야 하는 게 아니라
      			 사용자가 입력을 안 하고 생성 버튼만 눌러도 default 값으로 #플레이리스트 or 플레이리스트 #N 지정해서 넘겨주기 위함
      			 플레이리스트 #N의 경우 N은 사용자의 플레이리스트 생성 횟수를 반영해서 다음에 추가로 생성 시 N+1 -->
<!-- 기본값은 JavaScript로 설정 -->
<!-- <input type="text" id="plTitle" name="plTitle" /> -->
<!-- 사용자가 플레이리스트 제목을 입력하지 않아도 기본값으로 "플레이리스트 #N" 설정. CSS, JavaScript로 값 숨김 (해보는 중)
      		 	<input type="text" id="plTitle" name="plTitle" value="#플레이리스트" /> -->
