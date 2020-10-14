package com.hamonize.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.notice.service.mapper.NoticeMapper;

@Service
@Transactional
public class NoticeService {
	
	@Autowired
	NoticeMapper mapper;
	
		// 게시물 목록
		public List<NoticeVO> getList(NoticeVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(NoticeVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 상세
		public NoticeVO getView(NoticeVO vo) throws Exception {
			return mapper.getView(vo);
		}

}
