package com.master.vibe.model.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter @Setter
@Alias("UserLikeTagDTO")
public class UserLikeTagDTO {
    private String tagName;
    private int tagCount; // 필드 이름을 쿼리 결과 컬럼 이름과 일치시킴
}