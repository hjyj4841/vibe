document.addEventListener('DOMContentLoaded', function() {
    // Tagify 라이브러리 초기화
    const input = document.querySelector('#tags');
    const tagify = new Tagify(input, {
        delimiters: " ",
        maxTags: 5, 
		tagTextProp: 'value' // 태그의 텍스트 값 설정

    });
});
