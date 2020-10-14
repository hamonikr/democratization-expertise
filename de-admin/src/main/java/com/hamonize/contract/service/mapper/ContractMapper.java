package com.hamonize.contract.service.mapper;

import java.util.List;

import com.hamonize.contract.service.ContractVO;

public interface ContractMapper {
	
		// 게시물 목록
		public List<ContractVO> getList(ContractVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(ContractVO vo) throws Exception;
		// 게시물 등록
		public int save(ContractVO vo) throws Exception;
		// 게시물 수정
		public int update(ContractVO vo) throws Exception;
		// 게시물 상세
		public ContractVO getView(ContractVO vo) throws Exception;
		// 게시물 삭제
		public int delete(ContractVO vo) throws Exception;
		// 게시물 SEQ
		public int selectSEQ() throws Exception;
		// 견적 승인
		public int updateReqeust(ContractVO vo) throws Exception;
		

}
