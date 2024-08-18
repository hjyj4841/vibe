<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
    <!-- 플레이리스트 생성 -->
    <h1>플레이리스트 생성</h1>
    <!-- 브라우저가 폼 데이터를 저장하지 않도록 하는 속성 : autocomplete -->
    <form action="createPlaylist" method="post" autocomplete="off" enctype="multipart/form-data">
      <label for="plTitle">플레이리스트 제목:</label>
      <input type="text" id="plTitle" name="plTitle" class="hidden-value" />

	  <h2>태그 추가</h2>
      <ul id="tag-list" class="tag-list">
        <li><input type="text" name="tag1" placeholder="태그 입력" /></li>
        <li><input type="text" name="tag2" placeholder="태그 입력" /></li>
        <li><input type="text" name="tag3" placeholder="태그 입력" /></li>
        <li><input type="text" name="tag4" placeholder="태그 입력" /></li>
        <li><input type="text" name="tag5" placeholder="태그 입력" /></li>
      </ul>

      <!-- 삭제 금지! -->
      <label>ADD IMG : </label>
      <input type="file" id="plUrl" name="plUrl" accept="image/*" />
      <br />
      <!-- 아래 코드 뭐하려고 했던 거냐면. 플레이리스트 생성 시 제목을 무조건 입력해야 하는 게 아니라
      			 사용자가 입력을 안 하고 생성 버튼만 눌러도 default 값으로 #플레이리스트 or 플레이리스트 #N 지정해서 넘겨주기 위함
      			 플레이리스트 #N의 경우 N은 사용자의 플레이리스트 생성 횟수를 반영해서 다음에 추가로 생성 시 N+1 -->
      <!-- 기본값은 JavaScript로 설정 -->
      <!-- <input type="text" id="plTitle" name="plTitle" /> -->
      <!-- 사용자가 플레이리스트 제목을 입력하지 않아도 기본값으로 "플레이리스트 #N" 설정. CSS, JavaScript로 값 숨김 (해보는 중)
      		 	<input type="text" id="plTitle" name="plTitle" value="#플레이리스트" /> -->
      <button type="submit">플레이리스트 생성</button>
    </form>
  </body>
</html>
