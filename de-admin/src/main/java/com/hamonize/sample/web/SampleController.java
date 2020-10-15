package com.hamonize.sample.web;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import com.hamonize.file.FileUtil;
import com.hamonize.file.service.FileService;
import com.hamonize.file.service.FileVO;
import com.hamonize.login.service.SecurityMember;
import com.hamonize.sample.service.SampleService;
import com.hamonize.sample.service.SampleVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping("/sample")
public class SampleController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// @Resource(name = "sampleService")
	@Autowired
	private SampleService sampleService;

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

	@RequestMapping("/sampleList")
	public String sampleList(@RequestParam Map<String, String> params, HttpServletRequest request, SampleVO samplevo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		

		/**
		 * How to use session info geter
		 * @AuthenticationPrincipal SecurityMember user System.out.println("user=========" + user.getBizcd());
		 */

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		samplevo.setFirstRecordIndex(firstRecordIndex);
		samplevo.setRecordCountPerPage(recordCountPerPage);

		List<SampleVO> list = sampleService.getList(samplevo);
		int listCount = sampleService.getListCount(samplevo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sample/list";
	}


	/**
	 * 글을 등록한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */

	@RequestMapping("/sampleSave")
	public String sampleSave(HttpServletRequest request, SampleVO samplevo, ModelMap model) throws Exception {
		if (samplevo.getSeq() != null) {
			samplevo = sampleService.getView(samplevo);
			model.addAttribute("result", samplevo);
		}
		return "sample/save";
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
	@RequestMapping("/save")
	public String save(HttpServletRequest request, SampleVO samplevo, ModelMap model, @RequestParam Map<String, Object> params) throws Exception {
		
		//첨부파일 관련
		samplevo.setSeq(sampleService.selectSEQ());
		params.put("seq",samplevo.getSeq() );
		params.put("section","sample");
		
		List<MultipartFile> uploadFileList = new ArrayList<MultipartFile>();
		Map<String, List<MultipartFile>> uploadFile = new HashMap<String, List<MultipartFile>>();
		List<FileVO> fileList = null;
		
		MultipartRequest multipartReq = (MultipartRequest) request;
		Iterator<String> filenames = multipartReq.getFileNames();
		while (filenames.hasNext()) {
			String key = (String) filenames.next();
			uploadFile.put(key, multipartReq.getFiles(key));
			uploadFileList.addAll(multipartReq.getFiles(key));
		}
		if (uploadFileList != null && uploadFileList.size() > 0) {
			fileList = fileUtil.saveAllFiles(uploadFile);
			  if (fileList.isEmpty()) {
				  model.addAttribute("message","첨부파일에 문제가 생겼습니다. 관리자에 문의하세요."); 
				  model.addAttribute("url", "sampleList");
			  }
			 
		}
		int result = sampleService.save(samplevo, params, fileList);

		if (result > 0) {
			model.addAttribute("message", messageSource.getMessage("common.insert.success", null, Locale.getDefault()));
			model.addAttribute("url", "sampleList");

		} else {
			model.addAttribute("message", messageSource.getMessage("common.insert.fail", null, Locale.getDefault()));
			model.addAttribute("url", "sampleView?seq=" + samplevo.getSeq());
		}
		// return "redirect:sampleList?pageNo=1";
		return "cmmn/message";
	}


	/**
	 * 글을 수정한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/update")
	public String update(HttpServletRequest request, SampleVO samplevo, ModelMap model) throws Exception {
		System.out.println("update");
		System.out.println("Seq====" + samplevo.getSeq());
		int result = sampleService.update(samplevo);

//		if(result>0){
//			model.addAttribute("message",egovMessageSource.getMessage("성공"));
//			model.addAttribute("url", "sampleList");
//			
//		}else{
//			model.addAttribute("message",egovMessageSource.getMessage("실패"));
//			model.addAttribute("url", "sampleView?seq="+samplevo.getSeq());
//		}
		return "redirect:sampleList?pageNo=1";

	}


	/**
	 * 상세화면
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleView"
	 * @exception Exception
	 */
	@RequestMapping("/sampleView")
	public String sampleView(HttpServletRequest request, SampleVO samplevo, ModelMap model) throws Exception {
		CmmnMap param = new CmmnMap();
		param.put("seq", samplevo.getSeq());
		param.put("section","sample");
		samplevo = sampleService.getView(samplevo);
		model.addAttribute("result", samplevo);
		model.addAttribute("file", cmmnService.selectList("viewFile", param));
		return "sample/view";

	}


	/**
	 * 상세화면
	 * @param CmmnMap - 엑셀로 만들 CmmnMap
	 * @param model
	 * @return "sampleExcel"
	 * @exception Exception
	 */
	@RequestMapping("/sampleExcel")
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

}
