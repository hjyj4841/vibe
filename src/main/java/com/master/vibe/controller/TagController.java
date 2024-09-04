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
        model.addAttribute("playlistCode", plCode);

        // 플레이리스트에 연결된 기존 태그들
        List<PlaylistTag> existingTags = playlistTagService.searchTagPlaylist(plCode);
        model.addAttribute("existingTags", existingTags);

        // 모든 태그 목록을 가져와서 태그 추가 시 사용
        List<Tag> allTags = tagService.getAllTags();
        model.addAttribute("allTags", allTags);

        return "playlist/manageTags";
    }

    @PostMapping("/playlist/addTag")
    public String addTag(Integer plCode, String newTag, RedirectAttributes redirectAttributes) {
        // 서버에서 태그 추가 처리
        if (tagService.isTagExistsInPlaylist(plCode, newTag)) {
            redirectAttributes.addFlashAttribute("addErrorMessage", "이미 존재하는 태그입니다.");
        } else if (!tagService.canAddMoreTags(plCode)) {
            redirectAttributes.addFlashAttribute("addErrorMessage", "더 이상 추가할 수 없습니다.");
        } else {
            Tag tag = tagService.addTag(newTag);
            playlistTagService.addPlaylistTag(plCode, tag.getTagCode());
            redirectAttributes.addFlashAttribute("addSuccessMessage", "태그가 성공적으로 추가되었습니다.");
        }
        return "redirect:/playlist/manageTags?plCode=" + plCode;
    }


    @PostMapping("/playlist/deleteTags")
    public String deleteTags(@RequestParam Integer plCode,
                             @RequestParam(value = "tagCodes", required = false) List<Integer> tagCodes,
                             RedirectAttributes redirectAttributes) {
        if (tagCodes == null || tagCodes.isEmpty()) {
            redirectAttributes.addFlashAttribute("deleteErrorMessage", "삭제할 태그를 선택하세요.");
        } else {
            tagCodes.forEach(tagCode -> playlistTagService.deletePlaylistTag(plCode, tagCode));
            redirectAttributes.addFlashAttribute("deleteSuccessMessage", "태그가 성공적으로 삭제되었습니다.");
        }
        return "redirect:/playlist/manageTags?plCode=" + plCode;
    }
}
