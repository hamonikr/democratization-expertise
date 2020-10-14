package com.hamonize.license.web;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.license.service.LicenseMngrService;
import com.hamonize.license.service.vo.LicenseBizVO;
import com.hamonize.license.service.vo.LicenseVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping("/lcns")
public class LicenseMngrController {

	@Autowired
	private CmmnService cmmnService;

	@Autowired
	private LicenseMngrService lcnsSrvc;
	
	@Autowired
	private MessageSource messageSource;

	/**
	 * license view
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/viewForm.ivs")
	@RequestMapping(value = "/view.ivs")
	public String viewForm(@RequestParam Map<String, String> params, HttpServletRequest request, LicenseVO vo, LicenseBizVO bvo,
			ModelMap model) throws Exception {

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

		bvo = lcnsSrvc.getView(bvo);
		//vo.setUpper_seq(bvo.getSeq());
		List<LicenseVO> list = lcnsSrvc.getListLcns(vo);
		int listCount = lcnsSrvc.getListLcnsCount(vo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수

		model.addAttribute("result", bvo);
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

//		list.forEach(System.out::println);

		return "licenseMngr/view";
	}
	
	@RequestMapping(value = "/lcnsList.ivs")
	public String lcnsList(@RequestParam Map<String, String> params, HttpServletRequest request, LicenseVO vo, LicenseBizVO bvo,
			ModelMap model) throws Exception {

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

		//bvo = lcnsSrvc.getView(bvo);
		//vo.setUpper_seq(bvo.getSeq());
		List<LicenseVO> list = lcnsSrvc.getListLcns(vo);
		int listCount = lcnsSrvc.getListLcnsCount(vo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수

		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

//		list.forEach(System.out::println);

		return "licenseMngr/lcnsList";
	}


	/**
	 * license list
	 * @param params
	 * @param request
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list.ivs")
	public String noiceListView(@RequestParam Map<String, String> params, HttpServletRequest request, LicenseBizVO vo,
			ModelMap model) throws Exception {

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

		List<LicenseBizVO> list = lcnsSrvc.getList(vo);
		int listCount = lcnsSrvc.getListCount(vo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수

		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

		list.forEach(System.out::println);

		return "licenseMngr/list";
	}

}