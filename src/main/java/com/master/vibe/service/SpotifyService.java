package com.master.vibe.service;

import java.util.Base64;
import java.util.List;
import java.util.ArrayList;
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
import com.master.vibe.model.vo.Music;

@Service
public class SpotifyService {
	
	private final RestTemplate restTemplate = new RestTemplate();

	// token 발급 받는 메서드
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

    // 검색한 음악정보 요청해서 받아오는 메서드
	public ArrayList<Music> getMusicInfoForMusicName(String musicName, int offset) {
		String accessToken = getAccessToken();
		
		// 기능마다 바뀌는 구문
		String url = "https://api.spotify.com/v1/search?q=" + musicName + "&type=track&limit=10&offset=" + offset;
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		
		HttpEntity<String> request = new HttpEntity<String>(headers);
		
		ResponseEntity<JsonNode> response = restTemplate.exchange(url, HttpMethod.GET, request, JsonNode.class);
		JsonNode musicData = response.getBody();
		
		// api를 통해 response 받는 구문
		ArrayList<Music> musicInfo = new ArrayList<>();
		JsonNode trackInfo = musicData.get("tracks").get("items");
		
		for(JsonNode track : trackInfo) {
			
			JsonNode albumInfo = track.get("album");
			String id = track.get("id").asText();
			String albumUrl = albumInfo.get("images").get(0).get("url").asText();
			String albumName = albumInfo.get("name").asText();
			String artistName = track.get("artists").get(0).get("name").asText();
			String musicTitle = track.get("name").asText();
			
			Music music = new Music();
			music.setId(id);
			music.setAlbumName(albumName);
			music.setAlbumUrl(albumUrl);
			music.setArtistName(artistName);
			music.setMusicTitle(musicTitle);
			
			musicInfo.add(music);
		}		
		return musicInfo;
	}
	
	// 플레이리스트에 담겨 있는 음악정보 받아오는 메서드
	public ArrayList<Music> getMusicInfoByMusicCode(List<String> musicCodeList){
		String accessToken = getAccessToken();
		
		String str = "";
		
		for(String musicCode : musicCodeList) str += musicCode + ","; // 콤마를 구분자로 요청
		str = str.substring(0, str.length()-1); // 마지막 콤마 제거 위함
		
		String url = "https://api.spotify.com/v1/tracks?ids=" + str;
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		
		HttpEntity<String> request = new HttpEntity<String>(headers);
		
		ResponseEntity<JsonNode> response = restTemplate.exchange(url, HttpMethod.GET, request, JsonNode.class);
		JsonNode musicData = response.getBody();
		
		ArrayList<Music> musicInfo = new ArrayList<>();
		JsonNode trackInfo = musicData.get("tracks");
		
		for(JsonNode track : trackInfo) {
			JsonNode albumInfo = track.get("album");
			String id = track.get("id").asText();
			String albumUrl = albumInfo.get("images").get(0).get("url").asText();
			String albumName = albumInfo.get("name").asText();
			String artistName = track.get("artists").get(0).get("name").asText();
			String musicTitle = track.get("name").asText();
			
			Music music = new Music();
			music.setId(id);
			music.setAlbumName(albumName);
			music.setAlbumUrl(albumUrl);
			music.setArtistName(artistName);
			music.setMusicTitle(musicTitle);
			
			musicInfo.add(music);
		}
		
		return musicInfo;
	}
}
