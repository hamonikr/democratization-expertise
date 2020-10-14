package com.hamonize.sample.service.mapper;

import java.util.List;

import com.hamonize.sample.service.SampleVO;

public interface SampleMapper {
	
		// 게시물 목록
		public List<SampleVO> getList(SampleVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(SampleVO vo) throws Exception;
		// 게시물 등록
		public int save(SampleVO vo) throws Exception;
		// 게시물 수정
		public int update(SampleVO vo) throws Exception;
		// 게시물 상세
		public SampleVO getView(SampleVO vo) throws Exception;
		// 게시물 SEQ
		public int selectSEQ() throws Exception;
		

}
