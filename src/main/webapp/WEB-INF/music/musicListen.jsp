<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://sdk.scdn.co/spotify-player.js"></script>
<link rel="icon" href="/imgs/logo/logoB_small.png">
<title>VibeMaster</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #121212;
	color: white;
	text-align: center;
	margin-top: 50px;
}

button {
	background-color: #1DB954;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	margin: 10px;
	cursor: pointer;
	border-radius: 50px;
}

button:hover {
	background-color: #1ed760;
}
</style>
</head>
<body>
	<!-- Spotify SDK 로드 -->


	<!-- 외부 JavaScript 파일 로드 -->
	<!-- <script type="text/javascript" src="./js/spotifyPlayer.js"></script> -->

	<h1>Spotify Web Player</h1>
	<div>
		<button id="play-btn">Play</button>
		<button id="pause-btn">Pause</button>
	</div>
	<script>window.onload = function() {
    fetch(${token})
    .then(response => response.text())
    .then(token => {
        const trackUri = 'spotify:playlist:37i9dQZF1E38zbkWG5rHsm';

        window.onSpotifyWebPlaybackSDKReady = () => {
            const player = new Spotify.Player({
                name: 'Web Playback SDK Quick Start Player',
                getOAuthToken: cb => { cb(token); },
                volume: 0.5
            });

            player.addListener('ready', ({ device_id }) => {
                console.log('Ready with Device ID', device_id);
                playTrack(device_id, trackUri, token);
            });

            player.addListener('not_ready', ({ device_id }) => {
                console.log('Device ID has gone offline', device_id);
            });

            player.addListener('initialization_error', ({ message }) => {
                console.error(message);
            });

            player.addListener('authentication_error', ({ message }) => {
                console.error(message);
            });

            player.addListener('account_error', ({ message }) => {
                console.error(message);
            });

            player.connect();
        }

        function playTrack(device_id, trackUri, token) {
            fetch(`https://api.spotify.com/v1/me/player/play?device_id=${device_id}`, {
                method: 'PUT',
                body: JSON.stringify({ uris: [trackUri] }),
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
            }).then(response => {
                if (response.ok) {
                    console.log('Track is playing!');
                } else {
                    console.error('Error playing track:', response);
                }
            }).catch(error => {
                console.error('Error playing track:', error);
            });
        }
    });
}</script>

</body>
</html>
