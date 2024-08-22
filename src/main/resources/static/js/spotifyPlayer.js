window.onload = function() {
    fetch('/api/token')
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
}