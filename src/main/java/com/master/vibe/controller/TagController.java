package com.master.vibe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.master.vibe.service.PlaylistTagService;
import com.master.vibe.service.TagService;
import com.master.vibe.model.vo.PlaylistTag;
import com.master.vibe.model.vo.Tag;

import java.util.List;

@Controller
public class TagController {

    @Autowired
    private TagService tagService;

    @Autowired
    private PlaylistTagService playlistTagService;

    @GetMapping("/playlist/manageTags")
    public String manageTags(Integer plCode, Model model) {
        model.addAttribute("playlistCode", plCode); // 플레이리스트 코드 모델에 추가

        // 플레이리스트에 연결된 기존 태그들을 가져와서 모델에 추가
        List<PlaylistTag> existingTags = playlistTagService.searchTagPlaylist(plCode);
        model.addAttribute("existingTags", existingTags);

        // 모든 태그 목록을 가져와서 태그 추가 시 사용
        List<Tag> allTags = tagService.getAllTags();
        model.addAttribute("allTags", allTags);

        return "playlist/manageTags"; // 태그 관리 페이지로 이동
    }

    @PostMapping("/playlist/addTag")
    public String addTag(Integer plCode, String newTag, RedirectAttributes redirectAttributes) {
        // 서버에서 태그 추가 처리
        if (tagService.isTagExistsInPlaylist(plCode, newTag)) {
            // 이미 존재하는 태그인 경우 에러 메시지 설정
            redirectAttributes.addFlashAttribute("addErrorMessage", "이미 존재하는 태그입니다.");
        } else if (!tagService.canAddMoreTags(plCode)) {
            // 더 이상 태그를 추가할 수 없는 경우 에러 메시지 설정
            redirectAttributes.addFlashAttribute("addErrorMessage", "더 이상 추가할 수 없습니다.");
        } else {
            // 새로운 태그를 추가
            Tag tag = tagService.addTag(newTag);
            // 플레이리스트와 태그 간의 관계를 추가
            playlistTagService.addPlaylistTag(plCode, tag.getTagCode());
            // 성공 메시지 설정
            redirectAttributes.addFlashAttribute("addSuccessMessage", "태그가 성공적으로 추가되었습니다.");
        }
        // 태그 관리 페이지로 리다이렉트
        return "redirect:/playlist/manageTags?plCode=" + plCode;
    }

	@PostMapping("/playlist/deleteTags")
	public String deleteTags(@RequestParam("plCode") Integer plCode,
			@RequestParam(value = "tagCodes", required = false) List<Integer> tagCodes) {
		if (tagCodes == null || tagCodes.isEmpty()) {
			return "redirect:/playlist/manageTags?plCode=" + plCode;
		}

		for (int tagCode : tagCodes) {
			playlistTagService.deletePlaylistTag(plCode, tagCode);
		}

		return "redirect:/playlist/manageTags?plCode=" + plCode;
	}
}
