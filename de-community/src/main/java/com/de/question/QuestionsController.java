package com.de.question;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.de.answer.Answers;
import com.de.answer.AnswersService;
import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.tag.Tags;
import com.de.vote.Vote;
import com.de.vote.VoteService;
import com.de.wiki.Wiki;

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
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		questions.setFirstRecordIndex(firstRecordIndex);
		questions.setRecordCountPerPage(recordCountPerPage);

		List<Questions> list = qs.getList(questions);
		List<Wiki> tagList = qs.findAllTag();

//		for (int i=0;i<list.size();i++) {
//			System.out.println("users?" + list.get(i).getUsers().getUserno()+" : " + list.get(i).getUsers().getUsername());
//			System.out.println("Questions?" + list.get(i).getFirstuserno()+" : "+list.get(i));
//		}

		int listCount = qs.getListCount(questions);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("tagList", tagList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("vo", param);
		return "/questions/list";
	}


	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, Questions qvo, Tags tvo, LoginVO user,
			HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		} else {
			List<Wiki> tagList = qs.findAllTag();
			model.addAttribute("tagList", tagList);
			model.addAttribute("user", user);
			return "/questions/save";
		}
	}


	@RequestMapping(value = "/save.proc")
	public String saveproc(HttpServletRequest request, Model model, Questions vo, Vote vvo) throws Exception {

		System.out.println("aaaaaaaa=q vo === " + vo.toString());
		CmmnMap param = new CmmnMap();
		vo.setQuestionno(Integer.parseInt(cs.selectObject("selectQNO", param).getString("questionno")));
		vvo.setPno(vo.getQuestionno());
		vvo.setSection(vo.getSection());
		vvo.setUserno(vo.getUserno());
		System.out.println("editauth--?" + vo.getEditauth());
		// 질문등록
		qs.save(vo);
		// 투표등록
		vs.save(vvo);
		param.put("userno", vo.getUserno());
		param.put("score", 5);
		// 점수등록
		cs.updateObject("saveScore", param);
		return "redirect:/questions/list";
	}


	@RequestMapping("/view/{questionno}")
	public String view(@PathVariable("questionno") int questionno, Model model,
			@AuthenticationPrincipal SecurityMember user, HttpSession httpSession) throws Exception {
		// List<Tags> tagList = qs.tagList();
		CmmnMap param = new CmmnMap();
		List<Wiki> tagList = qs.findAllTag();
		//List<Answers> answerList = as.findAllByquestionno(questionno);
		List<Answers> answerList = as.getList(questionno);
		model.addAttribute("tagList", tagList);
		model.addAttribute("answerList", answerList);
		// 조회수 증가
		qs.updateReanCnt(questionno);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);

		model.addAttribute("result", qvo);
		param.put("questionno", questionno);
		model.addAttribute("history", cs.selectList("selectHistory", param));
		model.addAttribute("historyCnt", cs.selectCount("selectHistoryCnt", param));
		if (httpSession.getAttribute("userSession") != null)
			model.addAttribute("user", httpSession.getAttribute("userSession"));
		return "/questions/view";
	}


	@RequestMapping("/edit/{questionno}")
	public String edit(HttpServletRequest request, @PathVariable("questionno") int questionno, Model model,
			LoginVO user, HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		}
		// List<Tags> list = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();
		model.addAttribute("tagList", tagList);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);

		model.addAttribute("result", qvo);
		model.addAttribute("user", user);
		return "/questions/save";
	}


	@RequestMapping(value = "/edit.proc")
	public String editproc(HttpServletRequest request, Model model, Questions vo, LoginVO user, HttpSession httpSession)
			throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		}
		System.out.println("title? " + vo.getTitle());
		System.out.println("1에서? editauth 0으로 넘어온다>>> " + vo.getEditauth());
		// 질문수정
		qs.updateById(vo);
		return "redirect:/questions/list";
	}


	// 내 답변 목록
	@RequestMapping(value = "/myList")
	public String getMyQList(@RequestParam Map<String, String> params, Model model, Questions questions,
			@AuthenticationPrincipal SecurityMember user, @PageableDefault Pageable pageable) throws Exception {

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(100); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		questions.setFirstRecordIndex(firstRecordIndex);
		questions.setRecordCountPerPage(recordCountPerPage);

		List<Questions> list = qs.getMyList(questions);
		// List<Tags> tagList = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();

//		int listCount = qs.getMyListCount(questions);
		int listCount = list.size();
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("tagList", tagList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("vo", param);
		return "/questions/list";
	}

}