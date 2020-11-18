package com.de.tag;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.de.cmmn.CmmnMap;
import com.de.login.vo.LoginVO;
import com.de.question.QuestionsService;
import com.de.wiki.Wiki;
import com.de.wiki.WikiHistory;
import com.de.wiki.service.WikiService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/tags")
public class TagsController {

	@Autowired
	WikiService service;
	
	@Autowired
	QuestionsService qs;

	@RequestMapping("/list")
	public String tagslist(@RequestParam Map<String, String> params, @PageableDefault Pageable pageable, Wiki vo,
			Model model) throws Exception {
		System.out.println("--------tag list 출력--------");

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(30); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		System.out.println("firstRecordIndex==" + firstRecordIndex);
		System.out.println("recordCountPerPage==" + recordCountPerPage);
		vo.setFirstRecordIndex(firstRecordIndex);
		vo.setRecordCountPerPage(recordCountPerPage);
		vo.setSection("t");
		
		List<Wiki> get_list = service.getWikiList(vo);
		int [] tagno_cnt = new int[get_list.size()];

		for(int i=0;i<get_list.size();i++) {
			tagno_cnt[i] = service.getWikiCount(get_list.get(i).getWikino());
			get_list.get(i).setRelatedcnt(tagno_cnt[i]);
		}

		model.addAttribute("result", get_list);
		model.addAttribute("paginationInfo", paginationInfo);
		return "/tags/list";
	}

	@RequestMapping("/save")
	public String createTag(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession)
	throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";

		} else {

			List<Wiki> tagList = qs.findAllTag();
			model.addAttribute("tagList", tagList);

			return "/tags/createTag";
		}

	}
	@RequestMapping("/view/{wikino}")
	public String view(HttpServletRequest request, @PathVariable("wikino") int wikino, LoginVO user, Model model,
			HttpSession httpSession) throws Exception {

		user = (LoginVO) httpSession.getAttribute("userSession");

		Wiki wiki_view = service.getView(wikino);
		model.addAttribute("result", wiki_view);

		List<WikiHistory> history = service.getHistory(wikino);
		model.addAttribute("history", history);

		return "/tags/view";
	}

}
