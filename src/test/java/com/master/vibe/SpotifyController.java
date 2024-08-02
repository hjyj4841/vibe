<<<<<<<< HEAD:src/test/java/com/master/vibe/SpotifyController.java
package com.master.vibe;
========
package com.master.vibe.controller;
>>>>>>>> junyong:src/main/java/com/master/vibe/controller/SpotifyController.java

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

<<<<<<<< HEAD:src/test/java/com/master/vibe/SpotifyController.java
import com.master.vibe.SpotifyService;
========
import com.master.vibe.service.SpotifyService;
>>>>>>>> junyong:src/main/java/com/master/vibe/controller/SpotifyController.java

@Controller
public class SpotifyController {

	@Autowired
	private SpotifyService spotifyService;
	
	@GetMapping("/artist")
	public String artistForm() {
		return "artistForm";
	}
	
	@PostMapping("/artist")
	public String getArtist(@RequestParam("musicName") String musicName, Model model) {
		int offset = 0;
		ArrayList<ArrayList<String>> musicData = spotifyService.getArtistInfo(musicName, offset);
		
		model.addAttribute("musicData", musicData);
		return "artistInfo";
	}
}
