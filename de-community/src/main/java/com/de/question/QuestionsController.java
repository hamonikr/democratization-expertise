package com.de.question;


import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.de.notification.NoticeUser;
import com.de.notification.NotificationManager;
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

	@Autowired
	NotificationManager nm;

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
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈

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
	public String saveproc(@AuthenticationPrincipal SecurityMember user, HttpServletRequest request, Model model, NoticeUser nu, Questions vo, Vote vvo) throws Exception {

		System.out.println("aaaaaaaa=q vo === " + vo.toString());
		CmmnMap param = new CmmnMap();
		vo.setQuestionno(Integer.parseInt(cs.selectObject("selectQNO", param).getString("questionno")));
		vvo.setPno(vo.getQuestionno());
		vvo.setSection(vo.getSection());
		vvo.setUserno(vo.getUserno());
		System.out.println("editauth--?" + vo.getEditauth());
		
		
		// slack 연동 추가
		nu.setUsername(user.getUsername());
		nu.setSection("questions/view/");
		nu.setTitle(vo.getTitle());
		nu.setSeq(vo.getQuestionno());
		nu.setUrl("http://askos.co.kr/" + nu.getSection() + nu.getSeq());
		
//		nu.setUrl("http://askos.co.kr/" + nu.getSection() + nu.getSeq());
		
		System.out.println("url : " + nu.getUrl());
		System.out.println("title : " + nu.getTitle());
		
		nm.sendNotification(nu);
		
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
			@AuthenticationPrincipal SecurityMember user, HttpSession httpSession, HttpServletRequest request, HttpServletResponse response, LoginVO vo) throws Exception {
		// List<Tags> tagList = qs.tagList();
		CmmnMap param = new CmmnMap();
		List<Wiki> tagList = qs.findAllTag();
		//List<Answers> answerList = as.findAllByquestionno(questionno);
		List<Answers> answerList = as.getList(questionno);
		int cnt = as.getListCount(questionno);
		model.addAttribute("tagList", tagList);
		model.addAttribute("answerList", answerList);
		model.addAttribute("answerSelectedCount", cnt);

//		// 조회수 증가
    	Questions qvo = new Questions();
		qvo = qs.getView(questionno);
	
		//Cookie 설정
		Cookie[] cookies = request.getCookies();
        
        // 비교하기 위해 새로운 쿠키
        Cookie viewCookie = null;
       if(httpSession.getAttribute("userSession") != null) {
    	   
    	   model.addAttribute("user", httpSession.getAttribute("userSession"));
    	   System.out.println("httpSession--user? >>" + httpSession.getAttribute("userSession").toString());
    	   vo = (LoginVO) httpSession.getAttribute("userSession");
    	   
    	   System.out.println("vo.getUserno() --- >> "+vo.getUserno());
    	   //System.out.println("qvo qno userno=== > " + qvo.getFirstuserno());
       
    	   // 쿠키가 있을 경우 
       if (cookies != null && cookies.length > 0) {
           for (int i = 0; i < cookies.length; i++) {
               // Cookie의 name이 cookie + questionno와 일치하는 쿠키를 viewCookie에 넣어줌 
               if (cookies[i].getName().equals("cookie"+questionno)) { 
                   System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
                   viewCookie = cookies[i];
                   System.out.println("viewCookie " +viewCookie.getName()+"\ncookies[i].getValue()" + cookies[i].getValue());
                }
            }
        } 
        
        // 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
        if (viewCookie == null) {    
            System.out.println("cookie 없음");
            // 쿠키 생성(이름, 값)
            Cookie newCookie = new Cookie("cookie"+questionno, "|" + questionno + "|");
              
            // 쿠키 추가
            response.addCookie(newCookie);
           
           // 쿠키를 추가 시키고 조회수 증가시킴 작성자는 카운트에서 제외
          if(vo.getUserno() != qvo.getFirstuserno()) {
            qs.updateReanCnt(questionno);           	
          	}
          
        } else { // viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
            System.out.println("cookie 있음 ==> 쿠키에 저장된 값 : "+viewCookie.getName()+" : " + viewCookie.getValue() );
    
//            if(viewCookie.getValue() != vo.getUserno()) {
//                qs.updateReanCnt(questionno);
//            }
            
              // 쿠키 값 받아옴.
            String value = viewCookie.getValue();
            System.out.println("cookie 값 : " + value);
        }
       }
		model.addAttribute("result", qvo);
        
//		model.addAttribute("result", qvo);
		param.put("questionno", questionno);
		model.addAttribute("history", cs.selectList("selectHistory", param));
		model.addAttribute("historyCnt", cs.selectCount("selectHistoryCnt", param));
	
		
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

		boolean isMyQuestion = false;
		System.out.println("editedit === user"+user.getUserno());
		if(user.getUserno() == qvo.getFirstuserno()) {
			isMyQuestion = true;
		}else {
			isMyQuestion = false;
		}
		
		model.addAttribute("result", qvo);
		model.addAttribute("isMyQuestion", isMyQuestion);
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
		// 질문수정
		qs.updateById(vo);
		return "redirect:/questions/list";
	}
	
	@RequestMapping(value = "/delete/{questionno}")
	public String deleteproc(HttpServletRequest request,@PathVariable("questionno") int questionno, Model model, 
			Questions vo, LoginVO user, HttpSession httpSession,HttpServletResponse response)
			throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			return "redirect:/login";
		}
		// 질문수정
		int result = qs.deleteById(questionno,user);
		if(result == 1) {
			request.setAttribute("message","삭제 되었습니다.");
	    	request.setAttribute("url", "/questions/list");
	    	request.getRequestDispatcher("/login/message").forward(request, response);
		} else {
			request.setAttribute("message","자신의 글이 아닙니다.");
	    	request.setAttribute("url", "/questions/list");
	    	request.getRequestDispatcher("/login/message").forward(request, response);
		}
		return "";
	}

	// 내 답변 목록 - 회원
	@RequestMapping(value = "/myList")
	public String getMyList(@RequestParam Map<String, String> params, Model model, Questions questions,
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

	// 내 답변 목록 - 기업
	@RequestMapping(value = "/myListEnter")
	public String getMyListEnter(@RequestParam Map<String, String> params, Model model, Questions questions,
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

		List<Questions> list = qs.getMyListEnter(questions);
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