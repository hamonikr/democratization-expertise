package com.hamonize.saleplan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.saleplan.service.mapper.SalePlanMapper;

@Service
@Transactional
public class SalePlanService {
	
	@Autowired
	SalePlanMapper mapper;
	
		// 게시물 목록
		public List<SalePlanVO> getList(SalePlanVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(SalePlanVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 등록
		public int save(SalePlanVO vo) throws Exception {
			return mapper.save(vo);
		}
		// 게시물 수정
		public int update(SalePlanVO vo) throws Exception{
			return mapper.update(vo);
		}
		// 게시물 상세
		public SalePlanVO getView(SalePlanVO vo) throws Exception {
			return mapper.getView(vo);
		}
		// 게시물 삭제
		public int delete(SalePlanVO vo) throws Exception{
			return mapper.delete(vo);
		}
		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return mapper.selectSEQ();
		}
		// 견적 승인
		public int updateReqeust(SalePlanVO vo) throws Exception{
			return mapper.updateReqeust(vo);
		}

}
