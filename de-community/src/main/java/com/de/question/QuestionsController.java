package com.de.question;


import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;
import com.de.tag.Tags;
import com.de.vote.Vote;
import com.de.vote.VoteService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/questions")
public class QuestionsController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	QuestionsService qs;

	@Autowired
	VoteService vs;

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

		List<Questions> list = qs.getList(questions);
		List<Tags> tagList = qs.tagList();

		int listCount = qs.getListCount(questions);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("tagList", tagList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("vo", param);
		return "/questions/list";
	}


	@RequestMapping(value = "/save")
	public String save(Model model, Questions qvo, Tags tvo, @AuthenticationPrincipal SecurityMember user) {
		if (user == null) {
			return "redirect:/login";
		} else {
			List<Tags> list = qs.tagList();
			model.addAttribute("tag", list);
			return "/questions/save";
		}
	}


	@RequestMapping(value = "/save.proc")
	public String saveproc(HttpServletRequest request, Model model, Questions vo, Vote vvo) throws Exception {
		CmmnMap param = new CmmnMap();
		vo.setQuestionno(Integer.parseInt(cs.selectObject("selectQNO", param).getString("questionno")));
		vvo.setPno(vo.getQuestionno());
		vvo.setSection(vo.getSection());
		vvo.setUserno(vo.getUserno());
		// 질문등록
		qs.save(vo);
		// 투표등록
		vs.save(vvo);
		// model.addAttribute("sample", ss.findById(sample.getSeq()));
		return "redirect:/questions/list";
	}


	@RequestMapping("/view/{questionno}")
	public String view(@PathVariable("questionno") int questionno, Model model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {
		List<Tags> list = qs.tagList();
		model.addAttribute("tag", list);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);
		qs.updateReanCnt(questionno);
		model.addAttribute("result", qvo);
		model.addAttribute("user", user);
//		Optional<Questions> questions = qs.findById(questionNo);
//		Questions vo;
//		vo = questions.orElse(null);
//		qs.updateByIdReadCnt(vo);
//		model.addAttribute("result", questions.orElse(null));
		return "/questions/view";
	}


	@RequestMapping("/edit/{questionno}")
	public String edit(@PathVariable("questionno") int questionno, Model model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {
		List<Tags> list = qs.tagList();
		model.addAttribute("tag", list);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);
		model.addAttribute("result", qvo);
		model.addAttribute("user", user);
		// Optional<Questions> sample = qs.findById(questionno);
		// model.addAttribute("result", sample.orElse(null));
		return "/questions/save";
	}


	@RequestMapping(value = "/edit.proc")
	public String editproc(HttpServletRequest request, Model model, Questions vo) throws Exception {
		CmmnMap param = new CmmnMap();
		// 질문수정
		qs.save(vo);
		// model.addAttribute("sample", ss.findById(sample.getSeq()));
		return "redirect:/questions/list";
	}

//	@RequestMapping(value = "/edit.proc")
//	public String editproc(HttpServletRequest request, Model model, Questions vo) {
//		qs.updateById(vo);
//		return "redirect:/sample/list";
//	}

}
