const sections = document.querySelectorAll("section");
const mHtml = document.querySelector("html");
let page = 0; // 현재 표시된는 페이지

// 현재 위치한 윈도우창의 상단 부분으로 이동
function scrollTop(el, value) {
	let win;
	if (el.window === el) {
		win = el;
	} else if (el.nodeType === 9) {
		win = el.defaultView;
	}
	if (value === undefined) {
		return win ? win.pageYOffset : el.scrollTop;
	}
	if (win) {
		win.scrollTop(win.pageXOffset, value);
	} else {
		el.scrollTop = value;
	}
}

// scroll 못하게 막는 event
window.addEventListener(
	"wheel",
	function(e) {
		e.preventDefault();
	},
	{ passive: false }
);

// wheel을 돌렸을 때 발생하는 event
window.addEventListener("wheel", function(e) {
	if (e.deltaY > 0) {
		if (page == 1) return; // scroll 할 section
		page++;
	} else if (e.deltaY < 0) {
		if (page == 0) return;
		page--;
	}
	let posTop = page * this.window.innerHeight;
	scrollTop(mHtml, posTop);
});

// 페이지 로드시 html 상단으로 이동
scrollTop(mHtml, 0);

// listRank div 바뀌는 이벤트
const buttons = document.querySelectorAll(".rankButtonBox button");
const ranklists = document.querySelectorAll(".listRank");

for(let i = 0; i <= buttons.length; i++){
	buttons[i].addEventListener("click", function() {
		ranklists[i].style.opacity = 1;
		ranklists[i].style.zIndex = 1;
		switch(i){
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