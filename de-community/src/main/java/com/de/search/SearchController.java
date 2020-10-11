package com.de.search;


import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.de.answer.AnswersService;
import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;
import com.de.question.Questions;
import com.de.question.QuestionsService;
import com.de.vote.VoteService;
import com.de.wiki.Wiki;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/search")
public class SearchController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	QuestionsService qs;

	@Autowired
	VoteService vs;
	
	@Autowired
	AnswersService as;

	@Autowired
	CmmnService cs;

//	@RequestMapping(value = "/list")
//	public String getList(Model model, @PageableDefault Pageable pageable) {
//		System.out.println("----------questions----------");
//		Page<Questions> list = qs.findAll(pageable);
//		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
//				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
//				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");
//		List<Tags> tagList = qs.tagList();
//		model.addAttribute("tagList",tagList);
//		model.addAttribute("paging", list);
//		model.addAttribute("data", list.getContent());
//		for(int i = 0; i < list.getContent().size();i++) {
//			System.out.println("list====="+list.getContent().get(i));
//		}
//		for(int i = 0; i < tagList.size();i++) {
//			System.out.println("list====="+tagList.get(i));
//		}
//		return "/questions/list";
//	}

	@RequestMapping(value = "/list")
	public String getList(@RequestParam Map<String, String> params, Model model, Questions questions,
			@AuthenticationPrincipal SecurityMember user, @PageableDefault Pageable pageable) throws Exception {

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");
		System.out.println("sort==========" + questions.getSort());
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		questions.setFirstRecordIndex(firstRecordIndex);
		questions.setRecordCountPerPage(recordCountPerPage);

		//List<Questions> list = qs.getList(questions);
		List<CmmnMap> list = cs.selectList("totalSearch", param);
		for(int i = 0;i < list.size();i++) {
			System.out.println("asdasd====+"+list.get(i));
		}
		List<Wiki> tagList = qs.findAllTag();

		int listCount = qs.getListCount(questions);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		//model.addAttribute("tagList", tagList);
		model.addAttribute("paginationInfo", paginationInfo);
		//model.addAttribute("vo", param);
		return "/search/list";
	}

}