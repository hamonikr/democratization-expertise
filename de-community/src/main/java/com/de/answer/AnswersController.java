package com.de.answer;


import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.question.Questions;
import com.de.tag.Tags;
import com.de.vote.Vote;
import com.de.vote.VoteService;
import com.de.wiki.Wiki;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/answers")
public class AnswersController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	AnswersService as;

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

//	@RequestMapping(value = "/list")
//	public String getList(@RequestParam Map<String, String> params, Model model, Answers answers,
//			@AuthenticationPrincipal SecurityMember user, @PageableDefault Pageable pageable) throws Exception {
//
//		CmmnMap param = new CmmnMap();
//		param.putAll(params);
//
//		logger.info("----------excel param-----------------------");
//		logger.debug("");
//		logger.debug(param.toString());
//		logger.debug("");
//		logger.debug("----------excel param-----------------------");
//		//System.out.println("sort==========" + answers.getSort());
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
//		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
//		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈
//
//		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
//		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
//		//answers.setFirstRecordIndex(firstRecordIndex);
//		//answers.setRecordCountPerPage(recordCountPerPage);
//
//		List<Answers> list = qs.getList(answers);
//		//List<Tags> tagList = qs.tagList();
//		List<Wiki> tagList = qs.findAllTag();
//
//		int listCount = qs.getListCount(answers);
//		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
//		model.addAttribute("list", list);
//		model.addAttribute("tagList", tagList);
//		model.addAttribute("paginationInfo", paginationInfo);
//		model.addAttribute("vo", param);
//		return "/questions/list";
//	}


	@RequestMapping(value = "/save/{questionno}")
	public String save(Model model, Answers qvo,@PathVariable("questionno") int questionno,Answers vo, Vote vvo
			,LoginVO user, HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		} else {
			CmmnMap param = new CmmnMap();
			vo.setAnswerno(Integer.parseInt(cs.selectObject("selectANO", param).getString("answerno")));
			vo.setUserno(user.getUserno());
			vvo.setPno(vo.getAnswerno());
			vvo.setSection("A");
			vvo.setUserno(user.getUserno());
			// 질문등록
			as.save(vo);
			// 투표등록
			vs.save(vvo);
			return "redirect:/questions/view/"+questionno;
		}
	}


	@RequestMapping(value = "/save.proc")
	public String saveproc(HttpServletRequest request, Model model, Answers vo, Vote vvo
			,LoginVO user, HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		} else {
			CmmnMap param = new CmmnMap();
			vo.setAnswerno(Integer.parseInt(cs.selectObject("selectANO", param).getString("answerno")));
			vo.setUserno(user.getUserno());
			vvo.setPno(vo.getAnswerno());
			vvo.setSection("A");
			vvo.setUserno(user.getUserno());
			// 답변등록
			as.save(vo);
			// 투표등록
			vs.save(vvo);
			param.put("userno", vo.getUserno());
			param.put("score", 8);
			// 점수등록
			cs.updateObject("saveScore", param);
			return "redirect:/questions/view/"+vo.getQuestionno();
		}
	}
	
	@RequestMapping(value = "/selected/{answerno}")
	public String editproc(HttpServletRequest request, Model model,@PathVariable("answerno") int answerno, Answers vo, LoginVO user,
			HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		String referrer = request.getHeader("Referer");
		if (user == null) {
			return "redirect:/login";
		}
		// 답변 채택
		as.updateById(answerno);
		return "redirect:"+referrer;
	}


//	@RequestMapping("/view/{questionno}")
//	public String view(@PathVariable("questionno") int answerno, Model model,
//			@AuthenticationPrincipal SecurityMember user) throws Exception {
//		//List<Tags> tagList = qs.tagList();
//		List<Wiki> tagList = as.findAllTag();
//		model.addAttribute("tagList", tagList);
//		//조회수 증가
//		as.updateReanCnt(answerno);
//		
//		Answers avo = new Answers();
//		qvo = as.getView(answerno);
//		model.addAttribute("result", qvo);
//		if(user != null)
//		model.addAttribute("user", user);
//		return "/questions/view";
//	}
//
//
//	@RequestMapping("/edit/{questionno}")
//	public String edit(@PathVariable("questionno") int questionno, Model model,
//			@AuthenticationPrincipal SecurityMember user) throws Exception {
//		if (user == null) {
//			return "redirect:/login";
//		}
//		//List<Tags> list = qs.tagList();
//		List<Wiki> tagList = qs.findAllTag();
//		model.addAttribute("tagList", tagList);
//		Answers qvo = new Answers();
//		qvo = qs.getView(questionno);
//		model.addAttribute("result", qvo);
//		model.addAttribute("user", user);
//		return "/questions/save";
//	}
//
//
//	@RequestMapping(value = "/edit.proc")
//	public String editproc(HttpServletRequest request, Model model, Answers vo,@AuthenticationPrincipal SecurityMember user) throws Exception {
//		if (user == null) {
//			return "redirect:/login";
//		}
//		// 질문수정
//		qs.updateById(vo);
//		return "redirect:/questions/list";
//	}

//	@RequestMapping(value = "/edit.proc")
//	public String editproc(HttpServletRequest request, Model model, Questions vo) {
//		qs.updateById(vo);
//		return "redirect:/sample/list";
//	}

}
