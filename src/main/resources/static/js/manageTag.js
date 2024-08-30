document.addEventListener('DOMContentLoaded', function() {
	const MAX_TAGS = 5;

	// 태그 추가 폼의 유효성 검사
	const addTagForm = document.getElementById('addTagForm');
	const addTagInput = document.getElementById('newTag');
	const addTagError = document.getElementById('addTagError');
	const playlistCode = document.querySelector('input[name="plCode"]').value;

	addTagForm.addEventListener('submit', function(event) {
		// 입력된 태그 이름을 가지고 AJAX 요청을 보냄
		fetch(`/playlist/checkTag?plCode=${playlistCode}&tagName=${encodeURIComponent(addTagInput.value)}`)
			.then(response => response.json())
			.then(data => {
				if (data.exists) {
					addTagError.textContent = '이미 존재하는 태그입니다.';
					event.preventDefault(); // 폼 제출을 막음
				} else {
					addTagError.textContent = '';
				}
			})
			.catch(error => {
				console.error('Error:', error);
				addTagError.textContent = '태그 중복 확인 중 오류 발생.';
				event.preventDefault(); // 오류 발생 시 폼 제출을 막습니다.
			});
	});

	// 태그 삭제 폼의 유효성 검사
	const deleteTagForm = document.getElementById('deleteTagForm');
	const deleteTagError = document.getElementById('deleteTagError');

	deleteTagForm.addEventListener('submit', function(event) {
		// 체크된 태그 수를 확인
		const checkedTags = document.querySelectorAll('input[name="tagCodes"]:checked');
		if (checkedTags.length >= MAX_TAGS) {
			deleteTagError.textContent = '더 이상 추가할 수 없습니다.';
			event.preventDefault(); // 폼 제출을 막음
		} else {
			deleteTagError.textContent = '';
		}
	});
});

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
