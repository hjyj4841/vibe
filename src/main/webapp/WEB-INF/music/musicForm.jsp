<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="./css/reset.css" />
    <link rel="stylesheet" href="./css/search.css" />
    <link rel="stylesheet" href="./css/mypage.css" />
    <link rel="stylesheet" href="./css/musicForm.css" />
    <link rel="icon" href="/imgs/logo/logoB_small.png">
    <script src="https://kit.fontawesome.com/df04184d5c.js" crossorigin="anonymous"></script>
    <script src="/js/searchMusic.js"></script>
	<title>VibeMaster</title>
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
            <div class="myTagBox">
              <!-- 플레이리스트 목록으로 -->
              <a
                href="/showPlaylistInfo?plCode=${plCode}"
                class="goPlaylistListBtn"
              >
                <i class="fa-solid fa-arrow-left"></i>
              </a>

              <h2>Search Music</h2>
              <div class="searchMusicBox">
                <form class="mainSearchBox" onsubmit="return false;">
                  <input
                    type="text"
                    placeholder="아티스트, 곡 제목 등 검색어를 입력하세요."
                    id="musicName"
                    onkeyup="if(event.keyCode=='13'){searchMusic();}"
                    autocomplete="off"
                    required
                  />
                  <button id="searchBtn" type="button" onclick="searchMusic()">
                    <i class="fa-solid fa-magnifying-glass"></i>
                  </button>
                </form>
                <!-- 검색 결과를 표시할 영역 -->
                <div id="resultContainer">
                  <form class="addMusicform">
                    <div class="addMusicBox"></div>
                    <input
                      type="button"
                      value="add Music"
                      id="musicExistsInPlaylist"
                      onclick="addMusicList()"
                    />
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 플레이어 모달 -->
    <div id="playerModal" class="playerModal">
      <div class="modal-content">
        <span class="close">&times;</span>
        <div class="spotify-login-box">
          <p>
            Press <i class="fa-brands fa-spotify"></i> If you want Full Song
          </p>

          <!-- 음악 재생 iFrame -->
          <iframe
            id="main_frame"
            src=""
            width="300"
            height="380"
            frameborder="0"
            allowtransparency="true"
            allow="encrypted-media"
          ></iframe>
        </div>
      </div>
    </div>
    <script>
      let offset = 0;
      let plCode = "<c:out value='${plCode}'/>";

      function searchMusic() {
        offset = 0;
        $(".addMusicBox").scrollTop(0);
        $.ajax({
          url: "/showMusic",
          type: "get",
          data: {
            musicName: $("#musicName").val(),
            offset: offset,
          },
          success: function (musicData) {
            let viewMusicItem = "";
            $.each(musicData, function (index, music) {
              let addMusicItem =
                "<div>" +
                '<div class="musicListBox">' +
                '<div class="musicCheck">' +
                '<label class="checkLabel">' +
                '<input type="checkbox" name="selectedMusic" class="selectedMusic" onchange="listCheck()" value="' +
                music.id +
                '">' +
                "</label>" +
                "</div>" +
                '<div class="musicImg">' +
                '<img src="' +
                music.albumUrl +
                '">' +
                "</div>" +
                '<div class="musicDesc">' +
                "<div>" +
                music.musicTitle +
                "</div>" +
                "<div>" +
                music.artistName +
                " · " +
                music.albumName +
                "</div>" +
                "</div>" +
                '<div class="addMusicIcon">' +
                '<div class="playlistMusicActionBtn">' +
                `<a href="#" onclick="playMusic('` +
                music.id +
                `')"` +
                'class="musicPlayBtn" data-track-id="' +
                music.id +
                '">' +
                '<i class="fa-solid fa-circle-play"></i></a>' +
                "</div>" +
                '<i class="fa-solid fa-plus" onclick="addOneMusic(event)" data-code="' +
                music.id +
                '"></i>' +
                "</div>" +
                "</div>" +
                "</div>";
              viewMusicItem += addMusicItem;
            });
            $(".addMusicBox").html(viewMusicItem);
            offset += 10;

            $(".musicCheck, .musicImg, .musicDesc").click((e) => {
            	if($(e.currentTarget).parent().find(".selectedMusic").is(":checked")){
            		$(e.currentTarget).parent().find(".checkLabel").css("background-color", "#999");
            		$(e.currentTarget).parent().find(".selectedMusic").prop('checked', false);
            	}else{
            		$(e.currentTarget).parent().find(".checkLabel").css("background-color", "#02f958");
            		$(e.currentTarget).parent().find(".selectedMusic").prop('checked', true);
            		listCheck();
            	}
            });

            // 모달을 열도록 하는 예시
            document.querySelectorAll(".musicPlayBtn").forEach((button) => {
              button.addEventListener("click", (event) => {
                event.preventDefault(); // 링크 기본 동작 방지
                const trackId = button.getAttribute("data-track-id"); // trackId를 버튼에서 가져온다고 가정
                openModal(trackId);
              });
            });
          },
          error: function () {
            $(".addMusicBox").html("검색하신 내용이 없습니다.");
          },
        });
      }

      $(".addMusicBox").scroll(function (e) {
        var innerHeight = $(this).innerHeight();
        var scroll = $(this).scrollTop() + $(this).innerHeight();
        var height = $(this)[0].scrollHeight;

        if (height === scroll && offset !== 0) {
          $.ajax({
            url: "/showMusic",
            type: "get",
            data: {
              musicName: $("#musicName").val(),
              offset: offset,
            },
            success: function (musicData) {
              $.each(musicData, function (index, music) {
                let addMusicItem =
                  "<div>" +
                  '<div class="musicListBox">' +
                  '<div class="musicCheck">' +
                  '<label class="checkLabel">' +
                  '<input type="checkbox" name="selectedMusic" class="selectedMusic" onchange="listCheck()" value="' +
                  music.id +
                  '">' +
                  "</label>" +
                  "</div>" +
                  '<div class="musicImg">' +
                  '<img src="' +
                  music.albumUrl +
                  '">' +
                  "</div>" +
                  '<div class="musicDesc">' +
                  "<div>" +
                  music.musicTitle +
                  "</div>" +
                  "<div>" +
                  music.artistName +
                  " · " +
                  music.albumName +
                  "</div>" +
                  "</div>" +
                  '<div class="addMusicIcon">' +
                  '<div class="playlistMusicActionBtn">' +
                  `<a href="#" onclick="playMusic('` +
                  music.id +
                  `')" class="musicPlayBtn" data-track-id="` +
                  music.id +
                  `">` +
                  '<i class="fa-solid fa-circle-play"></i></a>' +
                  "</div>" +
                  '<i class="fa-solid fa-plus" onclick="addOneMusic(event)" data-code="' +
                  music.id +
                  '"></i>' +
                  "</div>" +
                  "</div>" +
                  "</div>";
                $(".addMusicBox").append(addMusicItem);
              });
              offset += 10;

              $(".musicCheck, .musicImg, .musicDesc").click((e) => {
              	if($(e.currentTarget).parent().find(".selectedMusic").is(":checked")){
              		$(e.currentTarget).parent().find(".checkLabel").css("background-color", "#999");
              		$(e.currentTarget).parent().find(".selectedMusic").prop('checked', false);
              	}else{
              		$(e.currentTarget).parent().find(".checkLabel").css("background-color", "#02f958");
              		$(e.currentTarget).parent().find(".selectedMusic").prop('checked', true);
              		listCheck();
              	}
              });

              // 모달을 열도록 하는 예시
              document.querySelectorAll(".musicPlayBtn").forEach((button) => {
                button.addEventListener("click", (event) => {
                  event.preventDefault(); // 링크 기본 동작 방지
                  const trackId = button.getAttribute("data-track-id"); // trackId를 버튼에서 가져온다고 가정
                  openModal(trackId);
                });
              });
            },
          });
        }
      });

      // 플레이어 모달을 열고 닫는 기능 추가
      const modal = document.getElementById("playerModal");
      const span = document.querySelector(".close");

      // 음악을 재생하는 함수
      function playMusic(event) {
        const musicCode = event.currentTarget.getAttribute("data-track-id");
        const iframe = document.getElementById("main_frame");

        // 자동 재생을 위해 autoplay 파라미터 추가
        iframe.src =
          "https://open.spotify.com/embed/track/" + musicCode + "?autoplay=1";
      }

      function openModal(trackId) {
        const iframe = document.getElementById("main_frame");
        iframe.src =
          "https://open.spotify.com/embed/track/" + trackId + "?autoplay=1";
        modal.style.display = "block";
      }

      function closeModal() {
        modal.style.display = "none";
        const iframe = document.getElementById("main_frame");
        iframe.src = ""; // 비우기 (혹은 stop 재생)
      }

      // 모달을 열도록 하는 예시
      document.querySelectorAll(".musicPlayBtn").forEach((button) => {
        button.addEventListener("click", (event) => {
          event.preventDefault(); // 링크 기본 동작 방지
          const trackId = button.getAttribute("data-track-id"); // trackId를 버튼에서 가져온다고 가정
          openModal(trackId);
        });
      });

      // 닫기 버튼 클릭 시 모달 닫기
      span.addEventListener("click", () => {
        closeModal();
      });

      // 모달 외부 클릭 시 모달 닫기
      window.addEventListener("click", (event) => {
        if (event.target === modal) {
          closeModal();
        }
      });

      function addOneMusic(event) {
        $.ajax({
          url: "/addOneMusic",
          type: "get",
          data: {
            plCode: plCode,
            musicId: $(event.target).attr("data-code"),
          },
          success: function (bool) {
            if (bool) {
              alert("곡이 추가 되었습니다.");

              listCheck();
            } else {
              alert("이미 추가된 곡입니다.");
            }
          },
        });
      }

      function listCheck() {
        // 선택된 체크박스의 ID 값을 배열로 가져오기
        const selectedMusicId = $("input[name='selectedMusic']:checked")
          .map(function () {
            return $(this).val();
          })
          .get();

        // 중복 체크 요청
        $.ajax({
          type: "post",
          url: "/checkMusicInPlaylist",
          data: {
            musicId: selectedMusicId,
            plCode: plCode,
          },
          traditional: true, // 배열 전송 시 필요
          success: function (response) {
            // 응답에 따라 사용자에게 결과를 알림
            $("input[name='selectedMusic']").each(function () {
              const musicId = $(this).val();
              if (response.includes(musicId)) {
                $(this).prop("checked", false);
                $(this).parent().css("background-color", "#999");
                alert("선택한 곡은 이미 플레이리스트에 있습니다.");
              }
            });
          },
        });
      }
      function addMusicList() {
        // 선택된 체크박스의 ID 값을 배열로 가져오기
        const selectedMusicId = $("input[name='selectedMusic']:checked")
          .map(function () {
            return $(this).val();
          })
          .get();

        $.ajax({
          url: "/addMusicToPlaylist",
          type: "post",
          data: {
            selectedMusic: selectedMusicId,
            plCode: plCode,
          },
          traditional: true, // 배열 전송 시 필요
          success: function () {
            alert(selectedMusicId.length + "개의 곡이 추가 되었습니다.");
            $("input[name='selectedMusic']").each(function () {
              $(this).prop("checked", false);
              $(this).parent().css("background-color", "#999");
            });
          },
          error: function () {
            alert("추가할 곡이 없습니다.");
          },
        });
      }
    </script>
  </body>
</html>
