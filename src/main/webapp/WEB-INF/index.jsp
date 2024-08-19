<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="./css/reset.css" />
    <link rel="stylesheet" href="./css/style.css" />
    <title>VibeMaster</title>
  </head>
  <body>
    <jsp:include page="tiles/header.jsp"></jsp:include>
    <!-- 메인 배너 -->
    <section id="mainbanner">
      <div id="mainchant">
        <p id="chant">Vibe that I want to BE</p>
        <p id="maintitle">VIBEMASTER</p>
      </div>

      <nav id="mainnav">
        <sec:authorize access="!isAuthenticated()">
          <a href="login" class="signIn">Sign In</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
          <a href="mypage" class="signIn">My Page</a>
        </sec:authorize>
        <a href="rankingHome" class="ranking">Ranking</a>
      </nav>
      <form class="mainSearchBox" action="searchPlaylist">
        <select name="select">
          <option value="title">Title</option>
          <option value="tag">Tag</option>
        </select>
        <input type="text" placeholder="Search Playlist..." name="search" />
        <button id="searchPlBtn" type="submit">
          <i class="fa-solid fa-magnifying-glass"></i>
        </button>
      </form>
    </section>

    <!-- DB에 따라 바뀔 부분 -->
    <!-- 리스트 박스 -->
    <div id="listBox">
      <div class="listTop">
        <div class="rankButtonBox">
          <div>
            <h2>TOP Rank</h2>
            <button>1st</button>
            <button>2nd</button>
            <button>3rd</button>
          </div>
        </div>
        <div class="listContainer">
          <!-- 랭크 1위 - 후에 jstl 사용해서 상위 리스트 3개만 표출 -->
          <section class="listRank">
            <img src="/imgs/playlistimg/list1.jpg" />
            <div class="listRankDesc">
              <img src="/imgs/playlistimg/list1.jpg" />
              <div class="listRankText">
                <!-- 플레이리스트 제목 -->
                <p>개쩌는 힙합클럽 MIX</p>
                <!-- 플레이리스트 작성자 닉네임 -->
                <p>귤까먹는귤귤이</p>
              </div>
            </div>
          </section>
          <!-- 랭크 2위 -->
          <section class="listRank">
            <img src="/imgs/playlistimg/list2.jpg" />
            <div class="listRankDesc">
              <img src="/imgs/playlistimg/list2.jpg" />
              <div class="listRankText">
                <!-- 플레이리스트 제목 -->
                <p>nowitzki</p>
                <!-- 플레이리스트 작성자 닉네임 -->
                <p>beenzino</p>
              </div>
            </div>
          </section>
          <!-- 랭크 3위 -->
          <section class="listRank">
            <img src="/imgs/playlistimg/list3.jpg" />
            <div class="listRankDesc">
              <img src="/imgs/playlistimg/list3.jpg" />
              <div class="listRankText">
                <!-- 플레이리스트 제목 -->
                <p>24:26</p>
                <!-- 플레이리스트 작성자 닉네임 -->
                <p>beenzino</p>
              </div>
            </div>
          </section>
        </div>
        <div class="emptyRight"></div>
      </div>
      <jsp:include page="tiles/footer.jsp"></jsp:include>
    </div>
    <script src="./js/main.js"></script>
    <script>
      if ("${deleteUser}" != "") alert("${deleteUser}");
      if('${registerMsg}' != '') alert('${registerMsg}');
    </script>
  </body>
</html>
