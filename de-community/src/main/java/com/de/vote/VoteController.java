package com.de.vote;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;

@Controller
@RequestMapping(value = "/vote")
public class VoteController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	VoteService vs;
	
	@Autowired
	CmmnService cs;

//	@RequestMapping(value = "/list")
//	public String getList(Model model, @PageableDefault Pageable pageable) {
//		System.out.println("----------questions----------");
//		Page<Vote> list = vs.findAll(pageable);
//		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
//				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
//				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");
//		List<Tags> tagList = vs.list();
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

	@ResponseBody
	@RequestMapping(value = "/like")
	public String like(HttpServletRequest request, Model model, Vote vo,@AuthenticationPrincipal SecurityMember user, HttpSession httpSession) throws Exception{
		if(user != null) {
		int result = 0;
			Vote vo2 = vs.getSeq(vo);
			if(vo2 != null) {
				vo2.setSenduserno(user.getUserno());
			result = vs.voteCheck(vo2);
			}
			if(result > 0) {
				return "FAIL";
			}else {
				vs.likes(vo);
			result = vs.saveVoteUser(vo2);
			CmmnMap param = new CmmnMap();
			param.put("userno", vo.getUserno());
			param.put("score", 1);
			// 점수등록
			cs.updateObject("saveScore", param);
			return "SUCCESS";
			}
		}else {
			return "LOGIN";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/dislike")
	public String dislike(HttpServletRequest request, Model model, Vote vo,@AuthenticationPrincipal SecurityMember user) throws Exception{
		if(user != null) {
		int result = 0;
		Vote vo2 = vs.getSeq(vo);
		if(vo2 != null) {
			vo2.setSenduserno(user.getUserno());
		result = vs.voteCheck(vo2);
		}
		if(result > 0) {
			return "FAIL";
		}else {
			vs.dislikes(vo);
		result = vs.saveVoteUser(vo2);
		CmmnMap param = new CmmnMap();
		param.put("userno", vo.getUserno());
		param.put("score", 1);
		// 점수등록
		cs.updateObject("saveScore", param);
		return "SUCCESS";
		}
		}else {
			return "LOGIN";
		}
	}

//	@RequestMapping(value = "/save.proc")
//	public String saveproc(HttpServletRequest request, Model model, Vote vo) {
//		System.out.println("vo====="+vo);
//		System.out.println(request.getRemoteAddr());
//		//vo.setUserIp(request.getRemoteAddr());
//		vs.save(vo);
//		// model.addAttribute("sample", ss.findById(sample.getSeq()));
//		return "redirect:/questions/save";
//	}

//	@RequestMapping("/view/{questionNo}")
//	public String view(@PathVariable("questionNo") int questionNo, Model model) {
//		Optional<Vote> questions = vs.findById(questionNo);
//		Vote vo;
//		vo = questions.orElse(null);
//		//vs.updateByIdReadCnt(vo);
//		model.addAttribute("result", questions.orElse(null));
//		return "/questions/view";
//	}

//	@RequestMapping("/edit/{seq}")
//	public String edit(@PathVariable("seq") int seq, Questions vo, Model model) {
//		Optional<Questions> sample = qs.findById(seq);
//		model.addAttribute("result", sample.orElse(null));
//		return "/sample/save";
//	}
	
//	@RequestMapping(value = "/edit.proc")
//	public String editproc(HttpServletRequest request, Model model, Questions vo) {
//		qs.updateById(vo);
//		return "redirect:/sample/list";
//	}

}
