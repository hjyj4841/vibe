   
       // 기본 이미지 URL 변수로 지정
       const DEFAULT_IMAGE_URL = 'http://192.168.10.6:8080/playlistImg/defaultCD.png';

       // 이미지 미리보기 기능
       function previewImg(event) {
           const file = event.target.files[0];
           const img = document.getElementById('createPlaylistImg');
           if (file) {
               console.log(file);
               const reader = new FileReader();
               reader.onload = function(e) {
                   img.src = e.target.result;
               }
               reader.readAsDataURL(file);
           } else {
               // 이미지 선택하지 않고 플레이리스트 생성 시 기본 이미지 설정
               img.src = DEFAULT_IMAGE_URL;
           }
       }

       // 페이지 로드 시 기본 이미지 설정
       window.onload = function() {
           const img = document.getElementById('createPlaylistImg');
           img.src = DEFAULT_IMAGE_URL;
       }

       // 기본 이미지로 리셋
       function resetDefaultImg() {
           const img = document.getElementById('createPlaylistImg');
           img.src = DEFAULT_IMAGE_URL;
           document.getElementById('plUrl').value = ""; // 파일 선택 초기화
       }