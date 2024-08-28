document.addEventListener('DOMContentLoaded', function() {
	// 메뉴 토글을 위한 변수 설정
	const menuToggle = document.getElementById('menuToggle');
    const menu = document.querySelector('.playlistMenu .menu');
	
	const subMenuToggle = document.querySelector('.playlistSubMenuBtn');
	const subMenu = document.querySelector('.playlistSubMenu');

  // 메인 메뉴 토글 이벤트
   if (menuToggle && menu) {
       menuToggle.addEventListener('click', function(event) {
           event.preventDefault(); // 링크의 기본 동작 방지
           menu.classList.toggle('show'); // 'show' 클래스를 토글하여 메뉴 표시/숨기기
       });
   }
	   
  // 서브 메뉴 토글 이벤트
  if (subMenuToggle && subMenu) {
      subMenuToggle.addEventListener('click', function(event) {
          event.preventDefault(); // 링크의 기본 동작 방지
          subMenu.classList.toggle('show'); // 'show' 클래스를 토글하여 메뉴 표시/숨기기
      });
  }
    
  // 문서 밖 클릭 시 메뉴 닫기
  document.addEventListener('click', function(event) {
      // 메인 메뉴 닫기
      if (menu && !menu.contains(event.target) && !menuToggle.contains(event.target)) {
          menu.classList.remove('show');
      }
      // 서브 메뉴 닫기
      if (subMenu && !subMenu.contains(event.target) && !subMenuToggle.contains(event.target)) {
          subMenu.classList.remove('show');
      }
  });
});




document.querySelectorAll('.plSubMenuBtn').forEach(button => {
    button.addEventListener('click', function(event) {
        event.preventDefault(); // 링크 기본 동작 방지
        const submenu = this.nextElementSibling; // 메뉴 박스 요소
        submenu.style.display = (submenu.style.display === 'block') ? 'none' : 'block'; // 토글 표시
    });
});

// 페이지 클릭 시 메뉴를 숨기기 (메뉴 외부 클릭 시)
document.addEventListener('click', function(event) {
    document.querySelectorAll('.playlistSubMenu').forEach(menu => {
        if (!menu.contains(event.target) && !menu.previousElementSibling.contains(event.target)) {
            menu.style.display = 'none';
        }
    });
});