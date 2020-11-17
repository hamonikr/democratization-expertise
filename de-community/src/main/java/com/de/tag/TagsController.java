package com.de.tag;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.de.cmmn.CmmnMap;
import com.de.wiki.Wiki;
import com.de.wiki.service.WikiService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/tags")
public class TagsController {

	@Autowired
	WikiService service;

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


		model.addAttribute("result", get_list);
		model.addAttribute("paginationInfo", paginationInfo);
		return "/tags/list";
	}

}
