package com.de.question;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
		System.out.println("sort==========" + questions.getSort());
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(100); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		questions.setFirstRecordIndex(firstRecordIndex);
		questions.setRecordCountPerPage(recordCountPerPage);

		List<Questions> list = qs.getList(questions);
		for(int i = 0; i < list.size();i++) {
			System.out.println("list====="+list.get(i));
		}
		//List<Tags> tagList = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();

		int listCount = qs.getListCount(questions);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("tagList", tagList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("vo", param);
		return "/questions/list";
	}


	@RequestMapping(value = "/save")
	public String save(Model model, Questions qvo, Tags tvo, @AuthenticationPrincipal SecurityMember user) throws Exception {
		if (user == null) {
			return "redirect:/login";
		} else {
			//List<Tags> tagList = qs.tagList();
			List<Wiki> tagList = qs.findAllTag();
			model.addAttribute("tagList", tagList);
			model.addAttribute("user",user);
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
		//List<Tags> tagList = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();
		List<Answers> answerList = as.findAllByquestionno(questionno);
		model.addAttribute("tagList", tagList);
		model.addAttribute("answerList", answerList);
		for(int i =0;i<answerList.size();i++) {
			System.out.println("answerList====="+answerList.get(i));
		}
		//조회수 증가
		qs.updateReanCnt(questionno);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);
		model.addAttribute("result", qvo);
		if(user != null)
		model.addAttribute("user", user);
		return "/questions/view";
	}


	@RequestMapping("/edit/{questionno}")
	public String edit(@PathVariable("questionno") int questionno, Model model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {
		if (user == null) {
			return "redirect:/login";
		}
		//List<Tags> list = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();
		model.addAttribute("tagList", tagList);
		Questions qvo = new Questions();
		qvo = qs.getView(questionno);
		model.addAttribute("result", qvo);
		model.addAttribute("user", user);
		return "/questions/save";
	}


	@RequestMapping(value = "/edit.proc")
	public String editproc(HttpServletRequest request, Model model, Questions vo,@AuthenticationPrincipal SecurityMember user) throws Exception {
		if (user == null) {
			return "redirect:/login";
		}
		// 질문수정
		qs.updateById(vo);
		return "redirect:/questions/list";
	}

//	@RequestMapping(value = "/edit.proc")
//	public String editproc(HttpServletRequest request, Model model, Questions vo) {
//		qs.updateById(vo);
//		return "redirect:/sample/list";
//	}

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
		for(int i = 0; i < list.size();i++) {
			System.out.println("list====="+list.get(i));
		}
		//List<Tags> tagList = qs.tagList();
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