package com.hamonize.main.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.cmmn.util.CmmnExcelService;
import com.hamonize.login.service.SecurityMember;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/main")
public class MainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CmmnService cmmnService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		
		CmmnMap param = new CmmnMap();
		param.put("bizcd",user.getBizcd());
		//사용자 세션의 회사롤
		if("2".equals(user.getBiz_auth_role()))
			param.put("biz_auth_role","총판사");
		else if("3".equals(user.getBiz_auth_role()))
			param.put("biz_auth_role","파트너사");
		
		model.addAttribute("notice", cmmnService.selectList("noticeList", param));
		model.addAttribute("estimate", cmmnService.selectList("estimategetList", param));
		model.addAttribute("saleplan", cmmnService.selectList("saleplangetList", param));
		model.addAttribute("contract", cmmnService.selectList("contractgetList", param));
		model.addAttribute("delivery", cmmnService.selectList("deliverygetList", param));
		model.addAttribute("inquiry", cmmnService.selectList("inquiryList", param));

		return "main/index";
	}
	
	/**
	 * 상세화면
	 * @param CmmnMap - 엑셀로 만들 CmmnMap
	 * @param model
	 * @return "sampleExcel"
	 * @exception Exception
	 */
	@RequestMapping("/excel.proc")
	public CmmnExcelService sampleExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String, String> params) throws Exception {

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");

		//int pageSize = this.propertiesService.getInt("pageSize"); // 페이지 크기
		//int pageUnit = this.propertiesService.getInt("pageUnit"); // 페이지 목록갯수

       	String key = "searchKeyword";
    	param.put(key, param.getString(key)); // 검색어
    	
		PaginationInfo paginationInfo = new PaginationInfo();
		key = "cPage";
		paginationInfo.setCurrentPageNo(param.getInt(key) > 0 ? param.getInt(key) : 1);
		key = "searchPageSize";
		//paginationInfo.setRecordCountPerPage(param.getInt(key) > 0 ? param.getInt(key) : pageUnit);	
		//paginationInfo.setPageSize(pageSize);
		param.put("firstIndex",paginationInfo.getFirstRecordIndex());
		param.put("lastIndex",paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		List<CmmnMap>  list = cmmnService.selectList("getLcnsExcel", param);
		
		String[] head ={"번호","계약번호","라이센스 번호","시작일","종료일"};
		param.put("header", head);		  // Excel 상단
		param.put("excelName",param.get("demandName")+"라이센스리스트");    // Excel 파일명
		param.put("list", list);          // Excel Data

		model.addAttribute("data", param);
		return new CmmnExcelService();
		//return new ModelAndView("cmmnExcelView", "data", param);
	}

}
