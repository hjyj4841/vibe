document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('musicName');
    const resultsContainer = document.getElementById('resultsContainer');

    searchInput.addEventListener('input', () => {
        const query = searchInput.value;

        // 입력값이 비어있으면 결과를 지웁니다
        if (!query.trim()) {
            resultsContainer.innerHTML = '';
            return;
        }

        // AJAX 요청을 통해 서버에서 데이터를 가져옵니다
        fetch('/searchMusic?query=' + encodeURIComponent(query))
            .then(response => response.json())
            .then(data => {
                // 결과를 처리하여 화면에 표시합니다
                if (data.length > 0) {
                    resultsContainer.innerHTML = data.map(item => 
                        `<div class="resultItem">${item.title} - ${item.artist}</div>`
                    ).join('');
                } else {
                    resultsContainer.innerHTML = '<div class="resultItem">검색 결과가 없습니다.</div>';
                }
            })
            .catch(error => {
                console.error('검색 중 오류 발생:', error);
                resultsContainer.innerHTML = '<div class="resultItem">검색 중 오류가 발생했습니다.</div>';
            });
    });
});
