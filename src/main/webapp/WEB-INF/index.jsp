<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/reset.css" />
    <link rel="stylesheet" href="/css/style.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script
      src="https://kit.fontawesome.com/df04184d5c.js"
      crossorigin="anonymous"
    ></script>
    <title>VibeMaster</title>
  </head>
  <body>
    <!-- 헤더 영역 --><!-- hidden 풀거 -->
    <header>
      <!-- 로고 -->
      <div id="logo">
        <img src="/imgs/logo/logoW.png" alt="" />
        <!-- 서버 주소로 수정 -->
      </div>
      <!-- nav1 영역 -->
      <div id="nav1">
        <a href="" id="search">Search</a>
        <a href="" id="contact">Contact</a>
      </div>
      <!-- nav2 영역 -->
      <div id="nav2">
        <a href="" id="signUp">Sign Up</a>
        <a href="" id="my">MY</a>
      </div>
    </header>

    <!-- 메인 배너 -->
    <section id="mainbanner">
      <div id="mainchant">
        <p id="chant">Vibe that I want to BE</p>
        <p id="maintitle">VIBEMASTER</p>
      </div>
      <nav id="mainnav">
        <a href="" id="signIn">Sign In</a>
        <a href="" id="ranking">Ranking</a>
      </nav>
    </section>

    <!-- DB에 따라 바뀔 부분 -->
    <!-- 리스트 박스 -->
    <div id="listBox">
      <!-- 랭크 1위 -->
      <section class="listRank">
        <div class="listRankBox">
          <img class="listImg" src="/imgs/playlistimg/list1.jpg" />
          <img class="listMiniImg" src="/imgs/playlistimg/list1.jpg" />

          <div class="listRankText">
            <!-- 플레이리스트 제목 -->
            <p>개쩌는 힙합클럽 MIX</p>
            <!-- 플레이리스트 작성자 닉네임 -->
            <p>귤까먹는귤귤이</p>
          </div>
          <div class="listRankIcon">
            <a href="">
              <i class="fa-solid fa-forward"></i>
            </a>
          </div>
        </div>
      </section>

      <!-- 랭크 2위 -->
      <section class="listRank">
        <div class="listRankBox">
          <img class="listImg" src="/imgs/playlistimg/list2.jpg" />
          <img class="listMiniImg" src="/imgs/playlistimg/list2.jpg" />

          <div class="listRankText">
            <!-- 플레이리스트 제목 -->
            <p>nowitzki</p>
            <!-- 플레이리스트 작성자 닉네임 -->
            <p>beenzino</p>
          </div>
          <div class="listRankIcon">
            <a href="">
              <i class="fa-solid fa-forward"></i>
            </a>
          </div>
        </div>
      </section>

      <!-- 랭크 3위 -->
      <section class="listRank">
        <div class="listRankBox">
          <img class="listImg" src="/imgs/playlistimg/list3.jpg" />
          <img class="listMiniImg" src="/imgs/playlistimg/list3.jpg" />

          <div class="listRankText">
            <!-- 플레이리스트 제목 -->
            <p>24:26</p>
            <!-- 플레이리스트 작성자 닉네임 -->
            <p>beenzino</p>
          </div>
          <div class="listRankIcon">
            <a href="">
              <i class="fa-solid fa-forward"></i>
            </a>
          </div>
        </div>
      </section>
      <footer>
        <p>Challenge to make Best PlayList</p>
        <nav id="footernav">
          <a href="" id="signIn">Sign In</a>
          <a href="" id="ranking">Ranking</a>
        </nav>
      </footer>
    </div>
    <script src="/js/main.js"></script>
  </body>
</html>
