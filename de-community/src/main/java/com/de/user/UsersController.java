package com.de.user;


import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.de.answer.Answers;
import com.de.cmmn.CmmnMap;
import com.de.cmmn.util.CodeMessage;
import com.de.enterprise.Enterprises;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.question.Questions;
import com.de.wiki.Wiki;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/users")
public class UsersController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private final boolean LOG_URL = true;

	@Autowired
	UsersService usersService;

	@Autowired
	UsersRepository repository;

	/**
	 * 사용자 활동정보 대시보드
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/activity/{userno}")
	public String dashboard(Model model, @PathVariable("userno") int userno, HttpSession session, LoginVO loginUserData,
			HttpServletRequest request, HttpSession sessionloginUser) throws Exception {
		request.getSession(false);
		loginUserData = (LoginVO) session.getAttribute("userSession");

		if (LOG_URL)
			logger.info(" -- url : /users/activity - seq : " + userno);

		boolean isUserNo = false;

		//Optional<Users> users = usersService.findByUserno(seq);
		Users users = usersService.getView(userno);
		System.out.println("seq users--->" + users.getUserno());
		System.out.println("sessionloginUser--> " + sessionloginUser.getAttribute("userSession"));

		System.out.println("loginUserData : " + loginUserData);

		if (loginUserData == null) {
			isUserNo = false;

		} else {
			if (loginUserData.getUserno() == users.getUserno()) {
				isUserNo = true;
			}
		}

		System.out.println("isUserNo : " + isUserNo);

		// Optional<Enterprises> enterprise = usersService.findEnterpriseno(seq);
		Enterprises enterprise = usersService.findEnterpriseno(userno);

		// 평판점수
		Integer score = usersService.getScore(userno);
		logger.info(" ---- score : " + score);
		if (score == null)
			score = 0;

		// 평판 그래프 데이터

		// 질문
		//int qCnt = usersService.cntQuestionsById(userno);
		Page<Questions> qList = usersService.findQuestionsByUserno(userno);
		
		Page<Questions> qqList = usersService.findAllByFirstusernoAndDeleteat(userno,0);
		
		
		// 답변
		Page<Answers> aList = usersService.findAnswerByUserno(userno);

		//채택된 답변 카운트
		int aSelCnt = usersService.cntAnswerById(userno);

		// 태그 n 위키
		Wiki vo = new Wiki();
		vo.setUserno(userno);

		// 태그
		vo.setSection("t");
		int tCnt = usersService.cntTagAndWikiById(vo);
		List<Wiki> tList = usersService.findTagAndWikiByUserno(vo);

		// 위키
		vo.setSection("h");
		int wCnt = usersService.cntTagAndWikiById(vo);
		List<Wiki> wList = usersService.findTagAndWikiByUserno(vo);

		if (LOG_URL) {
			//logger.info(" ------ qCnt : " + qCnt);
			logger.info(" ------ getTotalElements : " + qList.getTotalElements());
			logger.info(" ------ qList Content : " + qList.getContent());
			//logger.info(" ------ aCnt : " + aCnt);
			logger.info(" ------ getTotalElements : " + aList.getTotalElements());
			logger.info(" ------ aList Content : " + aList.getContent());
			logger.info(" ------ tCnt : " + tCnt);
			logger.info(" ------ tList Content : " + tList);
			logger.info(" ------ wCnt : " + wCnt);
			logger.info(" ------ wList Content : " + wList);
		}

		// System.out.println("1==========++"+ users.get().getUserprofileimg());
		model.addAttribute("user", users); // 프로필 정보
		model.addAttribute("isMypage", isUserNo); // 내 정보 유무
		model.addAttribute("enterprise", enterprise); // 회사명 정보

		model.addAttribute("score", score); // 평판점수

//		model.addAttribute("qCnt", qList.getTotalElements()); // 질문 전체 수
//		model.addAttribute("qList", qList.getContent()); // 질문 목록
				
		model.addAttribute("qqCnt", qqList.getTotalElements()); // 질문 전체 수
		model.addAttribute("qqList", qqList.getContent()); // 질문 목록

		
		model.addAttribute("aCnt", aList.getTotalElements()); // 답변 전체 수
		model.addAttribute("aList", aList.getContent()); // 답변 목록


		model.addAttribute("tCnt", tCnt); // 태그 전체 수
		model.addAttribute("tList", tList); // 태그 목록

		model.addAttribute("wCnt", wCnt); // 위키 전체 수
		model.addAttribute("wList", wList); // 위키 목록
//		model.addAttribute("tab", tab);
		
		model.addAttribute("selectedCnt", aSelCnt);

		return "/users/activity";
	}


	/**
	 * 사용자 목록
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String getList(@RequestParam Map<String, String> params, Model model, Users users,
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
		paginationInfo.setRecordCountPerPage(30); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		users.setFirstRecordIndex(firstRecordIndex);
		users.setRecordCountPerPage(recordCountPerPage);

		List<Users> list = usersService.getList(users);

		int listCount = usersService.getListCount(users);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("data", list);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("vo", param);
		return "/users/list";
	}


	/**
	 * 사용자 상세 정보
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/profile/{seq}", method = RequestMethod.GET)
	public String modify(Model model, @PathVariable("seq") int seq, HttpSession session, LoginVO loginUserData)
			throws Exception {
		loginUserData = (LoginVO) session.getAttribute("userSession");
		if (LOG_URL)
			logger.info(" -- url : /users/profile - seq : " + seq);

		boolean isUserNo = false;

		Optional<Users> user = usersService.findByUserno(seq);
		// Optional<Enterprises> enterprise = usersService.findEnterpriseno(seq);
		Enterprises enterprise = usersService.findEnterpriseno(seq);
		System.out.println("profile -- > enterprise name > " + enterprise.getEnterprisename());
		System.out.println("userat? " + enterprise.getUserat());

		logger.info(" ------ user : " + user);
		logger.info(" ------ enterprise : " + enterprise);

		if (loginUserData == null) {
			isUserNo = false;
		} else {
			if (loginUserData.getUserno() == seq) {
				isUserNo = true;
			}
		}

		model.addAttribute("user", user.orElse(null)); // 프로필 정보
		model.addAttribute("isMypage", isUserNo); // 내 정보 유무
		model.addAttribute("enterprise", enterprise); // 회사명 정보

		return "/users/profile";
	}


	/**
	 * 사용자 정보 수정
	 * @param model
	 * @param vo
	 * @param newslater
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(Model model, Users vo, UsersDetail userDetail) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /users/modify - user : " + vo + " // detail : " + userDetail);

		System.out.println("userDetail? " + userDetail.getEnterpriseno());
		usersService.updateUser(vo, userDetail);
		return "redirect:/users/activity/" + vo.getUserno();
	}


	/**
	 * 사용자 비밀번호 수정
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/modifyPw", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> modifyPassword(Model model, UserPwVO vo,
			@AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /users/modify - UserPwVO : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();

		vo.setUserno(loginUserData.getUserno());

		System.out.println("pw? -- > oldone : " + vo.getUserpassword());
		System.out.println("pw? -- > newone : " + vo.getUserpasswordnew());

		boolean updateVal = false;

		updateVal = usersService.updateUserPw(vo);
		System.out.println("updateVal...?" + updateVal);

		if (updateVal)
			map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else
			map.put("message", CodeMessage.MSG_100009_비밀번호가_일치하지_않습니다__다시_확인해주세요_);

		map.put("updateVal", updateVal);

		return map;
	}


	/**
	 * 프로필 이미지 업로드
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public HashMap<String, Object> upload(MultipartHttpServletRequest request,
			@AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /users/upload - request : " + request);

		HashMap<String, Object> map = new HashMap<String, Object>();

		Users vo = new Users();
		vo.setUserno(loginUserData.getUserno());

		boolean updateVal = usersService.upload(vo, request);

		if (updateVal)
			map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else
			map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);

		map.put("result", updateVal);
		return map;
	}


	/**
	 * 회사 목록
	 * @param enterName
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getEnterList", method = RequestMethod.POST)
	public HashMap<String, Object> getEnterList(String enterName, HttpServletRequest req) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /users/getEnterList - enterName : " + enterName);
		System.out.println("getEnterList?? --");

		HashMap<String, Object> map = new HashMap<String, Object>();

		List<Enterprises> list = usersService.getEnterList(enterName);
		System.out.println("getEnterList?? --");

		for (int i = 0; i < list.size(); i++) {
			System.out.println("enter====" + list.get(i).getEnterprisename());
		}
//		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
//		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);

		map.put("list", list);
		return map;
	}


	/**
	 * 사용자 점수 그래프
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getScoregraph", method = RequestMethod.POST)
	public HashMap<String, Object> getScoregraph(Model model, HttpServletRequest req) throws Exception {
		if (LOG_URL) {
			logger.info(" -- url : /users/getScoregraph");
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		Integer userno = Integer.valueOf(req.getParameter("userno"));

		if (userno != null) {
			String list = usersService.getScoregraph(userno);
			map.put("list", list);
		}

		return map;
	}

}
