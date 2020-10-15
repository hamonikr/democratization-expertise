package com.hamonize.estimate.service.mapper;

import java.util.List;

import com.hamonize.estimate.service.EstimateVO;

public interface EstimateMapper {
	
		// 게시물 목록
		public List<EstimateVO> getList(EstimateVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(EstimateVO vo) throws Exception;
		// 게시물 등록
		public int save(EstimateVO vo) throws Exception;
		// 게시물 수정
		public int update(EstimateVO vo) throws Exception;
		// 게시물 상세
		public EstimateVO getView(EstimateVO vo) throws Exception;
		// 게시물 삭제
		public int delete(EstimateVO vo) throws Exception;
		// 게시물 SEQ
		public int selectSEQ() throws Exception;
		// 견적 승인
		public int updateConsent(EstimateVO vo) throws Exception;
		

}
