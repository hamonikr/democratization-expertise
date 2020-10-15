package com.hamonize.notice.service.mapper;

import java.util.List;

import com.hamonize.notice.service.NoticeVO;

public interface NoticeMapper {
	
		// 게시물 목록
		public List<NoticeVO> getList(NoticeVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(NoticeVO vo) throws Exception;
		// 게시물 상세
		public NoticeVO getView(NoticeVO vo) throws Exception;
		

}
