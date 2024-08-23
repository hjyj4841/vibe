document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.getElementById('menuToggle');
    const menu = document.querySelector('.playlistMenu .menu');

    menuToggle.addEventListener('click', function(event) {
        event.preventDefault(); // 링크의 기본 동작 방지
        menu.classList.toggle('show'); // 'show' 클래스를 토글하여 메뉴 표시/숨기기
    });

    // 문서 밖 클릭 시 메뉴 닫기
    document.addEventListener('click', function(event) {
        if (!menu.contains(event.target) && !menuToggle.contains(event.target)) {
            menu.classList.remove('show');
        }
    });
});
