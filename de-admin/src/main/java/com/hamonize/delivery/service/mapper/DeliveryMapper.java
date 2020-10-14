package com.hamonize.delivery.service.mapper;

import java.util.List;

import com.hamonize.contract.service.ContractVO;
import com.hamonize.delivery.service.DeliveryVO;

public interface DeliveryMapper {
	
		// 게시물 목록
		public List<DeliveryVO> getList(DeliveryVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(DeliveryVO vo) throws Exception;
		// 게시물 등록
		public int save(DeliveryVO vo) throws Exception;
		// 게시물 수정
		public int update(DeliveryVO vo) throws Exception;
		// 게시물 상세
		public DeliveryVO getView(DeliveryVO vo) throws Exception;
		// 게시물 삭제
		public int delete(DeliveryVO vo) throws Exception;
		// 게시물 SEQ
		public int selectSEQ() throws Exception;
		// 견적 승인
		public int updateReqeust(DeliveryVO vo) throws Exception;
		

}
