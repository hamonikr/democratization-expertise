package com.hamonize.product.service.mapper;

import java.util.List;

import com.hamonize.product.service.ProductVO;
import com.hamonize.sample.service.SampleVO;

public interface ProductMapper {
	
		// 게시물 목록
		public List<ProductVO> getList(ProductVO vo) throws Exception;
		// 게시물 카운트
		public int getListCount(ProductVO vo) throws Exception;
		// 게시물 등록
		public int save(ProductVO vo) throws Exception;
		// 게시물 수정
		public int update(ProductVO vo) throws Exception;
		// 게시물 상세
		public ProductVO getView(ProductVO vo) throws Exception;
		

}
