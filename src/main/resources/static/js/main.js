const rankButton = document.querySelectorAll(".rankButtonBox div")
const rankList = document.querySelectorAll(".listRank");
const plDesc = document.querySelectorAll(".plDesc");
const rightArrow = document.querySelector(".emptyRight");
const leftArrow = document.querySelector(".emptyLeft img");
const listRankDesc = document.querySelectorAll(".listRankDesc");
const rankBox = document.querySelector(".rankButtonBox");
const linkA = document.querySelectorAll(".linkDesc");
const linkB = document.querySelectorAll(".plDesc > div > div > div > div")

rightArrow.addEventListener("click", function() {
	for(let i = 0; i < listRankDesc.length; i++){
		listRankDesc[i].classList.remove("hidden");
		plDesc[i].classList.add("hidden");
	}
	
	if(!rankButton[0].classList.contains("black")){
		rankButton[0].classList.add("black");
		rankButton[1].classList.remove("black");
		rankButton[2].classList.add("black");
		rankButton[1].style.opacity = 1;
		rankButton[1].style.zIndex = 1;
		rankList[0].classList.add("hidden");
		rankList[2].classList.add("hidden");
		rankList[1].classList.remove("hidden");
		rankList[0].style.opacity = 0;
		rankList[0].style.zIndex = 0;
		rankList[1].style.opacity = 1;
		rankList[1].style.zIndex = 1;
		
	} else if(!rankButton[1].classList.contains("black")){
		rankButton[1].classList.add("black");
		rankButton[0].classList.add("black");
		rankButton[2].classList.remove("black");
		rankButton[0].style.opacity = 0;
		rankButton[0].style.zIndex = 0;
		rankButton[2].style.opacity = 1;
		rankButton[2].style.zIndex = 1;
		rankList[0].classList.add("hidden");
		rankList[1].classList.add("hidden");
		rankList[2].classList.remove("hidden");
		rankList[2].style.opacity = 1;
		rankList[2].style.zIndex = 1;
		rankList[0].style.opacity = 0;
		rankList[0].style.zIndex = 0;
		
	} else if(!rankButton[2].classList.contains("black")){
		rankButton[2].classList.add("black");
		rankButton[1].classList.add("black");
		rankButton[0].classList.remove("black");
		rankButton[0].style.opacity = 1;
		rankButton[0].style.zIndex = 1;
		rankList[1].classList.add("hidden");
		rankList[2].classList.add("hidden");
		rankList[0].classList.remove("hidden");
		rankList[0].style.opacity = 1;
		rankList[0].style.zIndex = 1;
	}
})


leftArrow.addEventListener("click", function(){
	for(let i = 0; i < listRankDesc.length; i++){
		listRankDesc[i].classList.remove("hidden");
		plDesc[i].classList.add("hidden");
	}

	if(!rankButton[0].classList.contains("black")){
		rankButton[0].classList.add("black");
		rankButton[2].classList.remove("black");
		rankButton[1].classList.add("black");
		rankButton[2].style.opacity = 1;
		rankButton[2].style.zIndex = 1;
		rankList[0].classList.add("hidden");
		rankList[1].classList.add("hidden");
		rankList[2].classList.remove("hidden");
		rankList[0].style.opacity = 0;
		rankList[0].style.zIndex = 0;
		rankList[2].style.opacity = 1;
		rankList[2].style.zIndex = 1;
		
	} else if(!rankButton[1].classList.contains("black")){
		rankButton[1].classList.add("black");
		rankButton[2].classList.add("black");
		rankButton[0].classList.remove("black");
		rankButton[1].style.opacity = 0;
		rankButton[1].style.zIndex = 0;
		rankButton[0].style.opacity = 1;
		rankButton[0].style.zIndex = 1;
		rankList[1].classList.add("hidden");
		rankList[2].classList.add("hidden");
		rankList[0].classList.remove("hidden");
		rankList[0].style.opacity = 1;
		rankList[0].style.zIndex = 1;
		rankList[2].style.opacity = 0;
		rankList[2].style.zIndex = 0;
		
	} else if(!rankButton[2].classList.contains("black")){
		rankButton[2].classList.add("black");
		rankButton[0].classList.add("black");
		rankButton[1].classList.remove("black");
		rankButton[1].style.opacity = 1;
		rankButton[1].style.zIndex = 1;
		rankList[0].classList.add("hidden");
		rankList[2].classList.add("hidden");
		rankList[1].classList.remove("hidden");
		rankList[1].style.opacity = 1;
		rankList[1].style.zIndex = 1;
	}
})

function listRankDescToggle() {
	for (let i = 0; i < listRankDesc.length; i++) {
		const check = listRankDesc[i].classList.contains("hidden");

		if (check) {
			listRankDesc[i].classList.remove("hidden");
			plDesc[i].classList.add("hidden");
		} else {
			listRankDesc[i].classList.add("hidden");
			plDesc[i].classList.remove("hidden");
		}
	}
}

for (let i = 0; i < rankList.length; i++) {
	rankList[i].addEventListener("click", listRankDescToggle);
	linkA[i].addEventListener("click", function(event){
		event.stopPropagation();
	})
	linkB[i].addEventListener("click", function(event){
		event.stopPropagation();
	})
}









