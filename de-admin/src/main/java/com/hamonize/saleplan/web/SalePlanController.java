package com.hamonize.saleplan.web;


import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.estimate.service.EstimateVO;
import com.hamonize.file.FileUtil;
import com.hamonize.file.service.FileService;
import com.hamonize.login.service.SecurityMember;
import com.hamonize.saleplan.service.SalePlanService;
import com.hamonize.saleplan.service.SalePlanVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping("/saleplan")
public class SalePlanController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// @Resource(name = "sampleService")
	@Autowired
	private SalePlanService salePlanservice;

	@Autowired
	private CmmnService cmmnService;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private FileService fileService;

	@Autowired
	private MessageSource messageSource;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param SampleVO - 조회할 정보가 담긴 SampleVO
	 * @param model
	 * @return "SampleList"
	 * @exception Exception
	 */

	@RequestMapping("/list.ivs")
	public String saleplanList(@RequestParam Map<String, String> params, HttpServletRequest request, SalePlanVO vo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------param-----------------------");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		vo.setFirstRecordIndex(firstRecordIndex);
		vo.setRecordCountPerPage(recordCountPerPage);

		//사용자 세션의 회사코드 
		vo.setBizcd(user.getBizcd());
		
		List<SalePlanVO> list = salePlanservice.getList(vo);
		int listCount = salePlanservice.getListCount(vo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("userSession", user);
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "saleplan/list";
	}


	/**
	 * 글을 등록한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */

	@RequestMapping("/save.ivs")
	public String saleplanSave(HttpServletRequest request, SalePlanVO vo, ModelMap model
			,@AuthenticationPrincipal SecurityMember user) throws Exception {
		model.addAttribute("userSession", user);
		//견적요청 후 판매계획서 작성시
		model.addAttribute("price", request.getParameter("price"));
		model.addAttribute("p_seq", request.getParameter("seq"));
		//vo.setSeq(null);
		
		CmmnMap param = new CmmnMap();
		param.put("product_section", "os");
		model.addAttribute("getProduct", cmmnService.selectList("getProduct", param));
		
		if (vo.getSeq() != null) {
			vo = salePlanservice.getView(vo);
			model.addAttribute("result", vo);
		}
		return "saleplan/save";
	}


	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void upload(MultipartRequest request) {
		MultipartFile file1 = request.getFile("file1");
		System.out.println(file1.getName());
		System.out.println(file1.getOriginalFilename());
		System.out.println(file1.getContentType());
		System.out.println(file1.getSize());
		try {
			File filePath = new File("/tmp");
			if (!filePath.exists()) {
				// 폴더 없는 경우 생성한다
				filePath.mkdir();
			}
			file1.transferTo(new File("/home/ryan/test_upload/" + file1.getOriginalFilename()));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	/**
	 * 글을 등록한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/save.proc")
	public String save(HttpServletRequest request, SalePlanVO vo, ModelMap model, @RequestParam Map<String, Object> params) throws Exception {
		//seq 생성
		vo.setSeq(salePlanservice.selectSEQ());
		//business code 생성
		vo.setBusiness_code(business_code(vo));
		//첨부파일 관련
		//vo.setSeq(sampleService.selectSEQ());
		//params.put("seq",vo.getSeq() );
		//params.put("section","sample");
		
//		List<MultipartFile> uploadFileList = new ArrayList<MultipartFile>();
//		Map<String, List<MultipartFile>> uploadFile = new HashMap<String, List<MultipartFile>>();
//		List<FileVO> fileList = null;
//		
//		MultipartRequest multipartReq = (MultipartRequest) request;
//		Iterator<String> filenames = multipartReq.getFileNames();
//		while (filenames.hasNext()) {
//			String key = (String) filenames.next();
//			uploadFile.put(key, multipartReq.getFiles(key));
//			uploadFileList.addAll(multipartReq.getFiles(key));
//		}
//		if (uploadFileList != null && uploadFileList.size() > 0) {
//			fileList = fileUtil.saveAllFiles(uploadFile);
//			  if (fileList.isEmpty()) { 
//				  model.addAttribute("message","첨부파일에 문제가 생겼습니다. 관리자에 문의하세요."); 
//				  model.addAttribute("action", "close");
//			  }
//			 
//		}
		CmmnMap param = new CmmnMap();
		param.put("p_seq", vo.getP_seq());
		param = cmmnService.selectObject("price_chk", param);
		if(param != null) {
		if(Integer.parseInt(param.get("price").toString()) != vo.getPrice()) {
			model.addAttribute("message", messageSource.getMessage("saleplan.price.fail", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");
			return "cmmn/message";
		}
		}
		int result = salePlanservice.save(vo);
//		if(result > 0)
//			result = 0;
//		result = fileService.saveFile(params, fileList);

		if (result > 0) {
			model.addAttribute("message", messageSource.getMessage("saleplan.insert.success", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");

		} else {
			model.addAttribute("message", messageSource.getMessage("common.insert.fail", null, Locale.getDefault()));
			model.addAttribute("url", "view.ivs?seq=" + vo.getSeq());
		}
		// return "redirect:sampleList?pageNo=1";
		return "cmmn/message";
	}


	/**
	 * 글을 수정한다.
	 * @param SampleVO - 등록할 정보가 담긴 EstimateVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/update.proc")
	public String update(HttpServletRequest request, SalePlanVO vo, ModelMap model) throws Exception {
		System.out.println("update");
		System.out.println("Seq====" + vo.getSeq());
		int result = salePlanservice.update(vo);

		if (result > 0) {
			model.addAttribute("message", messageSource.getMessage("saleplan.update.success", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");

		} else {
			model.addAttribute("message", messageSource.getMessage("common.update.fail", null, Locale.getDefault()));
			model.addAttribute("url", "view.ivs?seq=" + vo.getSeq());
		}
		return "cmmn/message";

	}
	
	/**
	 * 글을 삭제한다.
	 * @param SampleVO - 등록할 정보가 담긴 EstimateVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/delete.proc")
	public String delete(HttpServletRequest request, SalePlanVO vo, ModelMap model) throws Exception {
		System.out.println("delete");
		System.out.println("Seq====" + vo.getSeq());
		int result = salePlanservice.delete(vo);

		if (result > 0) {
			model.addAttribute("message", messageSource.getMessage("common.delete.success", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");

		} else {
			model.addAttribute("message", messageSource.getMessage("common.delete.fail", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");
		}
		return "cmmn/message";

	}


	/**
	 * 상세화면
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleView"
	 * @exception Exception
	 */
	@RequestMapping("/view.ivs")
	public String sampleView(HttpServletRequest request, SalePlanVO vo, ModelMap model) throws Exception {
		CmmnMap param = new CmmnMap();
		//param.put("section","sample");
		vo = salePlanservice.getView(vo);
		param.put("product_section", vo.getProduct_section());
		param.put("section", "saleplan");
		param.put("seq", vo.getSeq());
		model.addAttribute("comment", cmmnService.selectList("commentList", param));
		model.addAttribute("result", vo);
		model.addAttribute("product", cmmnService.selectObject("getProductSection", param));
		return "saleplan/view";

	}
	
	/**
	 * 글을 수정한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/updateReqeust.proc")
	public String updateConsent(HttpServletRequest request, SalePlanVO vo, ModelMap model) throws Exception {
		System.out.println("consent==="+vo.getConsent());
//		if(vo.getRequest() > 0)
//			vo.setRequest(0);
//		else
//			vo.setRequest(1);
		int result = salePlanservice.updateReqeust(vo);
		if (result > 0 && vo.getRequest() == 1) {
			model.addAttribute("message", messageSource.getMessage("saleplan.consent.success", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");

		} else if (result > 0 && vo.getRequest() == 0) {
			model.addAttribute("message", messageSource.getMessage("saleplan.consentcancel.success", null, Locale.getDefault()));
			model.addAttribute("url", "list.ivs");

		}else {
			model.addAttribute("message", messageSource.getMessage("saleplan.consent.fail", null, Locale.getDefault()));
			model.addAttribute("url", "view.ivs?seq=" + vo.getSeq());
		}
		return "cmmn/message";

	}


	/**
	 * 상세화면
	 * @param CmmnMap - 엑셀로 만들 CmmnMap
	 * @param model
	 * @return "sampleExcel"
	 * @exception Exception
	 */
	@RequestMapping("/estimateExcel")
	public ModelAndView sampleExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String, String> params) throws Exception {

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");

//		int pageSize = this.propertiesService.getInt("pageSize"); // 페이지 크기
//		int pageUnit = this.propertiesService.getInt("pageUnit"); // 페이지 목록갯수
//
//       	String key = "searchKeyword";
//    	param.put(key, param.getString(key)); // 검색어
//    	
//		PaginationInfo paginationInfo = new PaginationInfo();
//		key = "cPage";
//		paginationInfo.setCurrentPageNo(param.getInt(key) > 0 ? param.getInt(key) : 1);
//		key = "searchPageSize";
//		paginationInfo.setRecordCountPerPage(param.getInt(key) > 0 ? param.getInt(key) : pageUnit);	
//		paginationInfo.setPageSize(pageSize);
//		param.put("firstIndex",paginationInfo.getFirstRecordIndex());
//		param.put("lastIndex",paginationInfo.getLastRecordIndex());
//		param.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
//		
//		List<CmmnMap>  list = cmmnService.selectList("sample.excel", param);
//		
//		String[] head ={"번호","제목","등록일"};
//		param.put("header", head);		  // Excel 상단
//		param.put("excelName","샘플");    // Excel 파일명
//		param.put("list", list);          // Excel Data

		return new ModelAndView("cmmnExcelView", "data", param);
	}
	
	public String business_code(SalePlanVO vo) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get ( cal.YEAR );
		String code = "";
		if("public".equals(vo.getInstt_section()))
			code = "PUBLIC_"+year+"_"+vo.getSeq();
		else
			code = "PRIVATE_"+year+"_"+vo.getSeq();
		System.out.println(code);
		return code;
		
	}

}
