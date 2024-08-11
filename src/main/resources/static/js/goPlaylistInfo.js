const tr = document.querySelectorAll("tr");

tr.forEach(t => {
	t.addEventListener("click", function(){
		window.location.href = "/showPlaylistInfo?plCode="
			+ t.getAttribute("data-code");
	});
});