// listRank div 바뀌는 이벤트
const buttons = document.querySelectorAll(".rankButtonBox div");
const ranklists = document.querySelectorAll(".listRank");
const rightArrow = document.querySelector(".emptyRight");
const leftArrow = document.querySelector(".emptyLeft");
const listRankDesc = document.querySelectorAll(".listRankDesc");
const rankBox = document.querySelectorAll(".rankButtonBox");

for (i = 0; i <= ranklists.length; i++) {
		ranklists[i].style.opacity = 1;
		ranklists[i].style.zIndex = 1;
		if(i = 0){
			rightArrow.addEventListener("click", function() {
				ranklists[0].style.opacity = 0;
				ranklists[0].style.zIndex = 0;
				ranklists[1].style.opacity = 1;
				ranklists[1].style.zIndex = 1;
				ranklists[2].style.opacity = 0;
				ranklists[2].style.zIndex = 0;
			});
		}
};

/*
for (let i = 0; i <= buttons.length; i++) {
	rightArrow.addEventListener("click", function() {
		listRankDesc[0].style.opacity = 0;
		listRankDesc[0].style.zIndex = 0;
	});
	leftArrow.addEventListener("click", function() {
		listRankDesc[0].style.opacity = 1;
		listRankDesc[0].style.zIndex = 1;
	});
	buttons[i].addEventListener("click", function() {
		ranklists[i].style.opacity = 1;
		ranklists[i].style.zIndex = 1;
		switch (i) {
			case 0:
				ranklists[1].style.opacity = 0;
				ranklists[1].style.zIndex = 0;
				ranklists[2].style.opacity = 0;
				ranklists[2].style.zIndex = 0;
				rightArrow.addEventListener("click", function() {
					listRankDesc[0].style.opacity = 0;
					listRankDesc[0].style.zIndex = 0;
				});
				leftArrow.addEventListener("click", function() {
					listRankDesc[0].style.opacity = 1;
					listRankDesc[0].style.zIndex = 1;
				});
				break;
			case 1:
				ranklists[0].style.opacity = 0;
				ranklists[0].style.zIndex = 0;
				ranklists[2].style.opacity = 0;
				ranklists[2].style.zIndex = 0;
				rightArrow.addEventListener("click", function() {
					listRankDesc[1].style.opacity = 0;
					listRankDesc[1].style.zIndex = 0;
				});
				leftArrow.addEventListener("click", function() {
					listRankDesc[1].style.opacity = 1;
					listRankDesc[1].style.zIndex = 1;
				});
				break;
			case 2:
				ranklists[0].style.opacity = 0;
				ranklists[0].style.zIndex = 0;
				ranklists[1].style.opacity = 0;
				ranklists[1].style.zIndex = 0;
				rightArrow.addEventListener("click", function() {
					listRankDesc[2].style.opacity = 0;
					listRankDesc[2].style.zIndex = 0;
				});
				leftArrow.addEventListener("click", function() {
					listRankDesc[2].style.opacity = 1;
					listRankDesc[2].style.zIndex = 1;
				});
				break;
		}
	});
}
*/

/*

rightArrow.addEventListener("click", function (){
	listRankDesc[0].style.opacity = 0;
	listRankDesc[0].style.zIndex = 0;
	});
	
leftArrow.addEventListener("click", function (){
	listRankDesc[0].style.opacity = 1;
	listRankDesc[0].style.zIndex = 1;
	});	
	
rightArrow.addEventListener("click", function (){
	listRankDesc[1].style.opacity = 0;
	listRankDesc[1].style.zIndex = 0;
	});
	
leftArrow.addEventListener("click", function (){
	listRankDesc[1].style.opacity = 1;
	listRankDesc[1].style.zIndex = 1;
	});

rightArrow.addEventListener("click", function (){
	listRankDesc[2].style.opacity = 0;
	listRankDesc[2].style.zIndex = 0;
	});
			
leftArrow.addEventListener("click", function (){
	listRankDesc[2].style.opacity = 1;
	listRankDesc[2].style.zIndex = 1;
	});

*/




