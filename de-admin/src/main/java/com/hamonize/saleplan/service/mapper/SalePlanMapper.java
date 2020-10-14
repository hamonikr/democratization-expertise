package com.hamonize.saleplan.service.mapper;

import java.util.List;

import com.hamonize.saleplan.service.SalePlanVO;

public interface SalePlanMapper {
	
		// 게시물 목록
		public List<SalePlanVO> getList(SalePlanVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(SalePlanVO vo) throws Exception;
		// 게시물 등록
		public int save(SalePlanVO vo) throws Exception;
		// 게시물 수정
		public int update(SalePlanVO vo) throws Exception;
		// 게시물 상세
		public SalePlanVO getView(SalePlanVO vo) throws Exception;
		// 게시물 삭제
		public int delete(SalePlanVO vo) throws Exception;
		// 게시물 SEQ
		public int selectSEQ() throws Exception;
		// 견적 승인
		public int updateReqeust(SalePlanVO vo) throws Exception;
		

}
