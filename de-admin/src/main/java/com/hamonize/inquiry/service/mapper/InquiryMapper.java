package com.hamonize.inquiry.service.mapper;
import java.util.List;

import com.hamonize.inquiry.service.AssigneeVO;
import com.hamonize.inquiry.service.InquiryVO;

public interface InquiryMapper {

	// 게시물 목록
	public List<InquiryVO> getList(InquiryVO vo) throws Exception;

	// 게시물 등록
	public int save(InquiryVO vo) throws Exception;

	// 게시물 상세
	public InquiryVO getView(InquiryVO vo) throws Exception;

	// 게시물 SEQ
	public int selectSEQ() throws Exception;

	public int getListCount(InquiryVO vo) throws Exception;
	
	public InquiryVO getCommmentList(InquiryVO vo) throws Exception;	
	
	public int updateProcStat(InquiryVO vo) throws Exception;
	public int updateComents(InquiryVO vo) throws Exception;
	
	public int deleteComments(InquiryVO vo) throws Exception;

	public List<AssigneeVO> getAssigneeList(AssigneeVO vo) throws Exception;
	
}
