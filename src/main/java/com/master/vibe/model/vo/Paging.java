package com.master.vibe.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Paging {

	private int page = 1; // 현재 페이지
	
	private int offset = 0; // 시작 위치
	private int limit = 10; // 보여지는 플레이리스트 수
	
	private int pageSize = 10;
	private int endPage = this.pageSize;
	private int startPage = this.page;
	
	private boolean prev;
	private boolean next;
	
	public Paging(int page, int total) {
		
		this.page = page;
		this.endPage = (int) Math.ceil((double) this.page / this.pageSize) * this.pageSize;
		this.startPage = this.endPage - this.pageSize + 1; 
		
		// 전체 개수를 통해서 마지막 페이지
		int lastPage = (int) Math.ceil((double) total / this.limit);
		
		if(lastPage < this.endPage) {
			this.endPage = lastPage;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < lastPage;
	}
}
