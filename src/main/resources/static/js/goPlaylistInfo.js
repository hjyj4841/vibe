const tr = document.querySelectorAll("tr");

tr.forEach(t => {
	t.addEventListener("click", function(){
		window.location.href = "/showPlaylistMusic?plCode="
			+ t.getAttribute("data-code");
	});
});