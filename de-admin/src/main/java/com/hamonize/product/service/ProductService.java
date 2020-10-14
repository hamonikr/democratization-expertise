package com.hamonize.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.product.service.mapper.ProductMapper;

@Service
@Transactional
public class ProductService {
	
	@Autowired
	ProductMapper mapper;
	
		// 게시물 목록
		public List<ProductVO> getList(ProductVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(ProductVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 등록
		public int save(ProductVO vo) throws Exception {
			return mapper.save(vo);
		}
		// 게시물 수정
		public int update(ProductVO vo) throws Exception{
			return mapper.update(vo);
		}
		// 게시물 상세
		public ProductVO getView(ProductVO vo) throws Exception {
			return mapper.getView(vo);
		}

}
