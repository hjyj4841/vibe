$(document).ready(function() {
	let page = 1;

	$(".tag-list-wrapper").scroll(function() {
		var innerHeight = $(this).innerHeight();
		var scroll = $(this).scrollTop() + innerHeight;
		var height = $(this)[0].scrollHeight;

		if (height === scroll) {
			page++;
			$.ajax({
				url: "/loadMoreTags",
				type: "POST",
				data: { page: page },
				success: function(tags) {
					let tagListBody = $(".tag-list-body");
					$.each(tags, function(index, tag) {
						let tagItem = '<tr>' +
							'<td>' + tag.tagName + '</td>' +
							'<td><input type="checkbox" name="tagCodes[]" value="' + tag.tagCode + '" /></td>' +
							'</tr>';
						tagListBody.append(tagItem);
					});
				}
			});
		}
	});
});

document.addEventListener('DOMContentLoaded', function() {
        // 현재 URL의 쿼리 파라미터에서 plCode 추출
        const urlParams = new URLSearchParams(window.location.search);
        const plCode = urlParams.get('plCode');

        // 페이지 상태를 기록 (현재 URL을 상태로 저장)
        history.replaceState({ plCode: plCode }, document.title, window.location.href);

        // popstate 이벤트 리스너 추가
        window.addEventListener('popstate', function(event) {
            if (event.state && event.state.plCode) {
                // plCode를 포함한 URL로 리디렉션
                window.location.href = `/showPlaylistInfo?plCode=${event.state.plCode}`;
            }
        });
    });
