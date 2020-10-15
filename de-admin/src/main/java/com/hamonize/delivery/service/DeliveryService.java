package com.hamonize.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.delivery.service.mapper.DeliveryMapper;

@Service
@Transactional
public class DeliveryService {
	
	@Autowired
	DeliveryMapper mapper;
	
		// 게시물 목록
		public List<DeliveryVO> getList(DeliveryVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(DeliveryVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 등록
		public int save(DeliveryVO vo) throws Exception {
			return mapper.save(vo);
		}
		// 게시물 수정
		public int update(DeliveryVO vo) throws Exception{
			return mapper.update(vo);
		}
		// 게시물 상세
		public DeliveryVO getView(DeliveryVO vo) throws Exception {
			return mapper.getView(vo);
		}
		// 게시물 삭제
		public int delete(DeliveryVO vo) throws Exception{
			return mapper.delete(vo);
		}
		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return mapper.selectSEQ();
		}
		// 견적 승인
		public int updateReqeust(DeliveryVO vo) throws Exception{
			return mapper.updateReqeust(vo);
		}

}
