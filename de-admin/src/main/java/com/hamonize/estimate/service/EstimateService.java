package com.hamonize.estimate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.estimate.service.mapper.EstimateMapper;

@Service
@Transactional
public class EstimateService {
	
	@Autowired
	EstimateMapper mapper;
	
		// 게시물 목록
		public List<EstimateVO> getList(EstimateVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(EstimateVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 등록
		public int save(EstimateVO vo) throws Exception {
			return mapper.save(vo);
		}
		// 게시물 수정
		public int update(EstimateVO vo) throws Exception{
			return mapper.update(vo);
		}
		// 게시물 상세
		public EstimateVO getView(EstimateVO vo) throws Exception {
			return mapper.getView(vo);
		}
		// 게시물 삭제
		public int delete(EstimateVO vo) throws Exception{
			return mapper.delete(vo);
		}
		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return mapper.selectSEQ();
		}
		// 견적 승인
		public int updateConsent(EstimateVO vo) throws Exception{
			return mapper.updateConsent(vo);
		}

}
