const rankButton = document.querySelectorAll("rankButtonBox div")
const rankList = document.querySelectorAll(".listRank");
const rightArrow = document.querySelector(".emptyRight");
const leftArrow = document.querySelector(".emptyLeft");
const listRankDesc = document.querySelectorAll(".listRankDesc");
const rankBox = document.querySelector(".rankButtonBox");

const first = document.querySelector("#fir");
const second = document.querySelector("#sec");
const third = document.querySelector("#thi");

function togglleActRank() {
	
	const check = listRankDesc[i].classList.contains("hidden");

	for(let i = 0; i <= rankButton.length; i++){
		switch(i){
			case 0:
				listRankDesc[i].classList.add("hidden");
				rankButton[i+1].classList.add("black");
				rankButton[i+2].classList.add("black");
				if(check){
					listRankDesc[i].classList.remove("hidden");
					rankButton[i+1].classList.remove("black");
					rankButton[i+2].classList.remove("black");
				}
				break;
			case 1:
				listRankDesc[i].classList.add("hidden");
				rankButton[i+1].classList.add("black");
				rankButton[i-1].classList.add("black");
				if(check){
					listRankDesc[i].classList.remove("hidden");
					rankButton[i+1].classList.remove("black");
					rankButton[i-1].classList.remove("black");
				}
				break;
			case 2:
				listRankDesc[i].classList.add("hidden");
				rankButton[i-2].classList.add("black");
				rankButton[i-1].classList.add("black");
				if(check){
					listRankDesc[i].classList.remove("hidden");
					rankButton[i-2].classList.remove("black");
					rankButton[i-1].classList.remove("black");
				}
				break;
		}
	}
}

rankList[0].addEventListener("click", togglleActRank);

/*
for(let i = 0; i <= rankList.length; i++){
	rankList[i].addEventListener("click", togglleActRank);
}
*/
