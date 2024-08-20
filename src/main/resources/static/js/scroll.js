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
  function (e) {
    e.preventDefault();
  },
  { passive: false }
);

// wheel을 돌렸을 때 발생하는 event
window.addEventListener("wheel", function (e) {
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