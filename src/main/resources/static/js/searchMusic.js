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
    });
});
