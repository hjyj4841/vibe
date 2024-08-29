// listRank div 바뀌는 이벤트
const buttons = document.querySelectorAll(".rankButtonBox button");
const ranklists = document.querySelectorAll(".listRank");
const rightArrow = document.querySelector(".emptyRight img");
const leftArrow = document.querySelector(".emptyLeft img");
const listRankDesc = document.querySelectorAll(".listRankDesc")

rightArrow.addEventListener("click", function (){
	listRankDesc[0].style.opacity = 0;
	listRankDesc[0].style.zIndex = 0;
	});
	
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
		rightArrow.addEventListener("click", function (){
			listRankDesc[0].style.opacity = 0;
			listRankDesc[0].style.zIndex = 0;
			});	
		
        break;
      case 1:
        ranklists[0].style.opacity = 0;
        ranklists[0].style.zIndex = 0;
        ranklists[2].style.opacity = 0;
        ranklists[2].style.zIndex = 0;
		rightArrow.addEventListener("click", function (){
			listRankDesc[1].style.opacity = 0;
			listRankDesc[1].style.zIndex = 0;
			});
		
        break;
      case 2:
        ranklists[0].style.opacity = 0;
        ranklists[0].style.zIndex = 0;
        ranklists[1].style.opacity = 0;
        ranklists[1].style.zIndex = 0;
		rightArrow.addEventListener("click", function (){
			listRankDesc[2].style.opacity = 0;
			listRankDesc[2].style.zIndex = 0;
			});
		
        break;
    }
  });
}

// 오른쪽 화살표를 누르면 플리에 들어있는 음악 5개 보이게



