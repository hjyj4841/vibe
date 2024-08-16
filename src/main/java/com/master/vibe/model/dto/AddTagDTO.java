package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter @Setter
public class AddTagDTO {
    private int playlistId;
    private List<Integer> tagCodes = new ArrayList<>();
}