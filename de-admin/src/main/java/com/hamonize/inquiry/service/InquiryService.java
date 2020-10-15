package com.hamonize.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.inquiry.service.mapper.InquiryMapper;
import com.hamonize.inquiry.service.InquiryVO;

@Service 
@Transactional
public class InquiryService {
	
	@Autowired
	InquiryMapper mapper;
	
		// 게시물 목록
		public List<InquiryVO> getList(InquiryVO vo) throws Exception {
			return mapper.getList(vo);
		}
	
		// 게시물 등록
		public int save(InquiryVO vo) throws Exception {
			return mapper.save(vo);
		}
		// 게시물 상세
		public InquiryVO getView(InquiryVO vo) throws Exception {
			return mapper.getView(vo);
		}

		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return mapper.selectSEQ();
		}

		public int getListCount(InquiryVO vo) throws Exception{
		    return mapper.getListCount(vo);
		}	

		public InquiryVO getCommmentList(InquiryVO vo) throws Exception{
		    return mapper.getCommmentList(vo);
		}	
		public int updateProcStat(InquiryVO vo) throws Exception{
		    return mapper.updateProcStat(vo);
		}
		public int updateComents(InquiryVO vo) throws Exception{
		    return mapper.updateComents(vo);
		}
		public int deleteComments(InquiryVO vo) throws Exception{
		    return mapper.deleteComments(vo);
		}
		
		public List <AssigneeVO> getAssigneeList(AssigneeVO vo) throws Exception{
			return mapper.getAssigneeList(vo);
		}

		
}
