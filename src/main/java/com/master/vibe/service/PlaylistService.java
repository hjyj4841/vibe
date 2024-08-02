package com.master.vibe.service;

import mapper.PlaylistMapper;
import com.master.vibe.model.vo.Playlist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlaylistService {

    @Autowired
    private PlaylistMapper playlistMapper;

    public void createPlaylist(Playlist playlist) {
        playlistMapper.insertPlaylist(playlist);
       
    }
}
