package com.hamonize.inquiry.web;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hamonize.login.service.SecurityMember;
import com.hamonize.saleplan.service.SalePlanVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.hamonize.inquiry.service.InquiryVO;
import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.inquiry.service.AssigneeVO;
import com.hamonize.inquiry.service.InquiryService;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    @Autowired
    private InquiryService service;
    
    @Autowired
    private MessageSource messageSource;
    
    @Autowired
    private CmmnService cmmnService;
    
    @RequestMapping("/list.ivs")
	public String inquiryList(@RequestParam Map<String, String> params, HttpServletRequest request, InquiryVO vo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {

	System.out.println("기술지원 페이지 진입 확인!! ");	
	CmmnMap param = new CmmnMap();
	param.putAll(params);
   
	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
	paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
	paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

	int firstRecordIndex = paginationInfo.getFirstRecordIndex();
	int recordCountPerPage = paginationInfo.getRecordCountPerPage();
	vo.setFirstRecordIndex(firstRecordIndex);
	vo.setRecordCountPerPage(recordCountPerPage);
	System.out.println("user ==> "+ user.getBiznm());
	String biznm = user.getBiznm();
	vo.setSupply_name(user.getBiznm());
	
	
	List<InquiryVO> list = service.getList(vo);
	int listCount = service.getListCount(vo);
	System.out.println("listCount>>>"+listCount);
	paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
	
	model.addAttribute("list", list);
	model.addAttribute("paginationInfo", paginationInfo);
	
	return "inquiry/list"; 
	}
    
    int seqTmp;
	@RequestMapping("/view.ivs")
	public String view(HttpServletRequest request,@AuthenticationPrincipal SecurityMember user, AssigneeVO avo, InquiryVO vo, ModelMap model) throws Exception {
		System.out.println("기술지원 상세 뷰페이지 진입!!");
		
		//담당자 리스트 불러오기
		avo.setBizcd(user.getBizcd());
		List<AssigneeVO> list = service.getAssigneeList(avo);
		model.addAttribute("alist", list);
		
		
		//작성글 불러오기 
		vo = service.getView(vo);	
		model.addAttribute("result", vo);
	
		System.out.println("inquiry seq ===>>" + vo.getSeq());
		vo.setInquiry_seq(vo.getSeq());
		seqTmp = vo.getInquiry_seq();
		
		System.out.println("coment seq ===>>" + seqTmp);
		
		System.out.println("proc_stat ===>" + vo.getProc_stat());
		CmmnMap param = new CmmnMap();
		param.put("seq", vo.getSeq());
		param.put("section","tchnlgy");
		
		//작성글에 대한 댓글 불러오기
		vo = service.getCommmentList(vo);	
		model.addAttribute("commentList", vo);	
		model.addAttribute("file", cmmnService.selectList("viewFile", param));
		
		return "inquiry/view";

	}

		
	
	 @RequestMapping("/save.proc")
	public String save(HttpServletRequest request, InquiryVO vo, ModelMap model, @RequestParam Map<String, Object> params) throws Exception {
	    	System.out.println("답변 등록 눌렀을때");

	    	System.out.println("Seq====" + vo.getSeq());
	    	System.out.println("seqTmp==> "+ seqTmp); 
	    	System.out.println("comments ==> " + vo.getComments());
	    	System.out.println("assignee====" + vo.getAssignee());

	    	vo.setInquiry_seq(seqTmp);
	    	
	      	//문의글 tb 상태값 변경
	    	System.out.println("getProc_stat ==> " + vo.getProc_stat());
	    	
	    	int result_proc = vo.getProc_stat();
	    		
	    	if(result_proc==1 || result_proc==2) {
	    	    service.updateProcStat(vo);
	    	    System.out.println("처리상태 업데이트 성공!");
	    		    
	    	//코멘트 tb 내용 저장 
	    	int result = service.save(vo);
			
	    	if (result > 0) {
				model.addAttribute("message", messageSource.getMessage("common.insert.success", null, Locale.getDefault()));
				model.addAttribute("url", "list.ivs");

			} else {
				model.addAttribute("message", messageSource.getMessage("common.insert.fail", null, Locale.getDefault()));
				model.addAttribute("url", "view.ivs?seq=" + vo.getSeq());
			}
	    	    
	    	} else if(result_proc == 0) {
	    	    service.updateProcStat(vo);
	    	    System.out.println("본사요청 취소나 수정할때!");

	    	} else if(result_proc == 3) {
	    	    service.updateProcStat(vo);
	    	    System.out.println("본사요청함!");

	    	} else {
	    	    System.out.println("처리상태 업데이트 실패!");
	    	}

		    			
	return "cmmn/message";
	}
	 

	@RequestMapping("/update.proc")
	@ResponseBody
	public int update(HttpServletRequest request, InquiryVO vo, ModelMap model) throws Exception {
	    System.out.println("수정 동작 확인");
	    vo.setInquiry_seq(seqTmp);
	     
	     System.out.println("전달 받은 값 확인 ===>>" + vo.getTitle() + " " +vo.getComments() +" " +"proc==>"+vo.getProc_stat());
	     System.out.println("seq >>>" + vo.getInquiry_seq());
	     System.out.println("assignee>>" + vo.getAssignee());
	     
	     //inquiry_answer tb 업데이트
	     int result = service.updateComents(vo);
	     
	     //inquiry tb prc도 업데이트
	     service.updateProcStat(vo);
	     
	     if (result == 1) {
		 System.out.println("수정 성공 ");
	     } else {
		 System.out.println("수정 실패 ");
	     }
		     	     
	     return result;
	 }
	 
	 @RequestMapping("/delete.proc")
	 @ResponseBody
	public int delete(HttpServletRequest request, InquiryVO vo, ModelMap model) throws Exception {
	    System.out.println("삭제 동작 확인");
	    vo.setInquiry_seq(seqTmp);
	     System.out.println("title ==> "+vo.getTitle());
	     System.out.println("seq ==> "+vo.getInquiry_seq());
	     System.out.println("proc_stat==>" +vo.getProc_stat());
	     
	    int result = service.deleteComments(vo);
	     if (result == 1) {
		 System.out.println("삭제 성공");
		 service.updateProcStat(vo);
	     } else {
		 System.out.println("삭제 실패 ");
	     }
	     
	     return result;
	 }
	 
}
