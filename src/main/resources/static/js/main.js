// listRank div 바뀌는 이벤트
const buttons = document.querySelectorAll(".rankButtonBox button");
const ranklists = document.querySelectorAll(".listRank");

for (let i = 0; i <= buttons.length; i++) {
  buttons[i].addEventListener("click", function () {
    ranklists[i].style.opacity = 1;
    ranklists[i].style.zIndex = 1;
    switch (i) {
      case 0:
        ranklists[1].style.opacity = 0;
        ranklists[1].style.zIndex = 0;
        ranklists[2].style.opacity = 0;
        ranklists[2].style.zIndex = 0;
        break;
      case 1:
        ranklists[0].style.opacity = 0;
        ranklists[0].style.zIndex = 0;
        ranklists[2].style.opacity = 0;
        ranklists[2].style.zIndex = 0;
        break;
      case 2:
        ranklists[0].style.opacity = 0;
        ranklists[0].style.zIndex = 0;
        ranklists[1].style.opacity = 0;
        ranklists[1].style.zIndex = 0;
        break;
    }
  });
}