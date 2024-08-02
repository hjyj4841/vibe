<<<<<<<< HEAD:src/test/java/com/master/vibe/SpotifyService.java
package com.master.vibe;
========
package com.master.vibe.service;
>>>>>>>> junyong:src/main/java/com/master/vibe/service/SpotifyService.java

import java.util.ArrayList;
import java.util.Base64;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;

@Service
public class SpotifyService {
	
	private final RestTemplate restTemplate = new RestTemplate();
	
	private String getAccessToken() {
		
		String clientId = "d0a1ae63ef0149c08c1d1e32cfc89a0c";
		String clientSecret = "f5f454d030c84d6f8be33c6839795342";
		String url = "https://accounts.spotify.com/api/token";
		
		String credentials = clientId + ":" + clientSecret;
		String base64Credentials = new String(Base64.getEncoder().encode(credentials.getBytes()));
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.set("Authorization", "Basic " + base64Credentials);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("grant_type", "client_credentials");
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String,String>>(body, headers);
		
		ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
		return response.getBody().get("access_token").toString();
	}
	
	public ArrayList<ArrayList<String>> getArtistInfo(String musicName, int offset) {
		String accessToken = getAccessToken();
		String url = "https://api.spotify.com/v1/search?q=" + musicName + "&type=track&limit=20&offset=" + offset;
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		
		HttpEntity<String> request = new HttpEntity<String>(headers);
		
		ResponseEntity<JsonNode> response = restTemplate.exchange(url, HttpMethod.GET, request, JsonNode.class);
		JsonNode musicData = response.getBody();
		
		ArrayList<ArrayList<String>> musicInfo = new ArrayList<ArrayList<String>>();
		JsonNode trackInfo = musicData.get("tracks").get("items");
		
		for(JsonNode track : trackInfo) {
			ArrayList<String> musicInfo2 = new ArrayList<String>();
			
			JsonNode albumInfo = track.get("album");
			String albumUrl = albumInfo.get("images").get(0).get("url").asText();
			String albumName = albumInfo.get("name").asText();
			String artistName = track.get("artists").get(0).get("name").asText();
			String musicTitle = track.get("name").asText();
			
			musicInfo2.add(albumUrl);
			musicInfo2.add(albumName);
			musicInfo2.add(artistName);
			musicInfo2.add(musicTitle);
			
			musicInfo.add(musicInfo2);
		}		
		return musicInfo;
	}
	
}
