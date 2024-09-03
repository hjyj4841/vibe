document.addEventListener('DOMContentLoaded', function() {
	const MAX_TAGS = 5;

	// 태그 추가 폼의 유효성 검사
	const addTagForm = document.getElementById('addTagForm');
	const addTagInput = document.getElementById('newTag');
	const playlistCode = document.querySelector('input[name="plCode"]').value;

	addTagForm.addEventListener('submit', function(event) {
		event.preventDefault(); // 폼 제출 기본 동작 방지
		
		fetch(`/playlist/checkTag?plCode=${playlistCode}&tagName=${encodeURIComponent(addTagInput.value)}`)
			.then(response => response.json())
			.then(data => {
				if (data.exists) {
					alert('이미 존재하는 태그입니다.');
				} else {
					addTagForm.submit(); // 폼 제출
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('태그 중복 확인 중 오류 발생.');
			});
	});

	// 태그 삭제 폼의 유효성 검사
	const deleteTagForm = document.getElementById('deleteTagForm');

	deleteTagForm.addEventListener('submit', function(event) {
		const checkedTags = document.querySelectorAll('input[name="tagCodes[]"]:checked');
		if (checkedTags.length === 0) {
			alert('삭제할 태그를 선택하세요.');
			event.preventDefault(); // 폼 제출을 막음
		} else if (checkedTags.length > MAX_TAGS) {
			alert('삭제할 태그 수는 최대 ' + MAX_TAGS + '개입니다.');
			event.preventDefault(); // 폼 제출을 막음
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

