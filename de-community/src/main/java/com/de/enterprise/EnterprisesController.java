package com.de.enterprise;


import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.de.answer.Answers;
import com.de.answer.AnswersService;
import com.de.cmmn.util.CodeMessage;
import com.de.login.service.SecurityMember;
import com.de.question.Questions;
import com.de.user.Users;
import com.de.user.UsersDetail;
import com.de.wiki.Wiki;
import com.de.wiki.service.WikiService;


/**
 * @author LukeHan
 * @since 2020. 08. 11.
 * @version 1.0
 *
 * <pre>
 * Name : UserController.java
 * Description  : TODO
 * 
 * << 개정이력(Modification Information) >>
 *   
 *   수정일				수정자			수정내용
 * ==============================================
 *  2020. 08. 11.		LukeHan		최초 생성
 *
 * </pre>
 */

@Controller
@RequestMapping(value = "/enterprises")
public class EnterprisesController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private final boolean LOG_URL = true;

	@Autowired
	EnterpriseService service;

	@Autowired
	AnswersService answService;

	@Autowired
	WikiService wikiService;

	@Autowired
	EnterprisesRepository repository;

	/**
	 * 기업회원 활동정보 대시보드
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/activity/{seq}", method = RequestMethod.GET)
	public String dashboard(Model model, @PathVariable("seq") int seq,
			@AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/activity - seq : " + seq);

		boolean isUserNo = false;

		if (loginUserData == null) {
			isUserNo = false;
		} else {
			if (loginUserData.getEnterpriseno() == seq && loginUserData.getRepresentat() == 1) {
				isUserNo = true;
			} else {
				isUserNo = false;
			}
		}

		Optional<Enterprises> enterprises = service.findByEnterpriseno(seq);
		System.out.println("enterprises========+" + enterprises);
		UsersDetail vo = new UsersDetail();

		vo.setEnterpriseno(seq);

		// 평판점수
		Integer score = service.getScore(seq);
		if (score == null)
			score = 0;

		// 질문
		System.out.println("==========질문================");
		Questions qVo = new Questions();
		qVo.setUserno(seq);
		List<Questions> qList = service.getQuestionList(qVo);
		int qCnt = service.getQuestionListCnt(qVo);

		// 답변
		System.out.println("==========답변================");
		Answers answVo = new Answers();
		answVo.setUserno(seq);
		List<Answers> answList = answService.getAnswerList(answVo);
		int answCnt = answService.getAnswerListCnt(answVo);

		// 태그 n 위키
		Wiki wVo = new Wiki();
		wVo.setUserno(seq);

		// 태그
		wVo.setSection("t");
		wVo.setUserno(seq);
		int tCnt = wikiService.getWikiListCntFromCom(wVo);
		List<Wiki> tList = wikiService.getWikiListFromCom(wVo);

		// 위키
		wVo.setSection("w");
		wVo.setUserno(seq);
		int wCnt = wikiService.getWikiListCntFromCom(wVo);
		List<Wiki> wList = wikiService.getWikiListFromCom(wVo);

		List<Users> usersAtStatus = service.getMembersList(vo); // 승인 대기 회원 목록
		System.out.println("usersAtStatus=======+" + usersAtStatus);
		model.addAttribute("usersAtStatus", usersAtStatus);

		model.addAttribute("enterprise", enterprises.orElse(null)); // 프로필 정보
		model.addAttribute("isMypage", isUserNo); // 내 정보 유무

		model.addAttribute("score", score); // 평판점수

		model.addAttribute("qCnt", qCnt); // 질문 전체 수
		model.addAttribute("qList", qList); // 질문 목록

		model.addAttribute("aCnt", answCnt); // 답변 전체 수
		model.addAttribute("aList", answList); // 답변 목록

		model.addAttribute("tCnt", tCnt); // 태그 전체 수
		model.addAttribute("tList", tList); // 태그 목록

		model.addAttribute("wCnt", wCnt); // 위키 전체 수
		model.addAttribute("wList", wList); // 위키 목록

		model.addAttribute("isMypage", isUserNo); // 내 정보 유무

		return "/enterprises/activity";
	}


	/**
	 * 기업회원 목록
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String enterprisesList(Model model, @PageableDefault Pageable pageable) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/list - pageable : " + pageable);
		Page<Enterprises> list = service.findAll(pageable);

		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");

		model.addAttribute("paging", list);
		model.addAttribute("data", list.getContent());
		return "/enterprises/list";
	}


	/**
	 * 기업회원 상세 정보
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/profile/{seq}", method = RequestMethod.GET)
	public String modify(Model model, @PathVariable("seq") int seq) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/profile - seq : " + seq);

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int enterSeq = 4;

		Optional<Enterprises> enterprise = service.findByEnterpriseno(seq);

		logger.info(" ------ enterprise : " + enterprise);

		if (!enterprise.isPresent()) {
			return "redirect:/enterprises/list";
		}

		model.addAttribute("enter", enterprise.orElse(null)); // 파트너사 정보
		model.addAttribute("isMypage", seq == enterSeq); // 내 정보 유무

		return "/enterprises/profile";
	}


	/**
	 * 기업회원 정보 수정
	 * @param model
	 * @param vo
	 * @param newslater
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(Model model, Enterprises vo, @AuthenticationPrincipal SecurityMember loginUserData)
			throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/modify - Enterprises : " + vo);

		System.out.println("loginuser enterpriseno ? " + loginUserData.getEnterpriseno());
		System.out.println("area? " + vo.getEnterprisearea());
		System.out.println("enterpriseabout" + vo.getEnterpriseabout());
		System.out.println("vo--->" + vo.toString());
		service.updateEnterprises(vo);

		return "redirect:/enterprises/activity/" + vo.getEnterpriseno();
	}


	/**
	 * 기업회원 비밀번호 수정
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyPw", method = RequestMethod.POST)
	public HashMap<String, Object> modifyPassword(Model model, EnterprisePwVO vo) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/modify - EnterprisePwVO : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		int enterpriseno = 4;
		vo.setEnterpriseno(enterpriseno);

		boolean updateVal = service.updateEnterprisePw(vo);

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
	public HashMap<String, Object> upload(MultipartHttpServletRequest request) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/upload - request : " + request);

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		int enterpriseno = 4;

		Enterprises vo = new Enterprises();
		vo.setEnterpriseno(enterpriseno);

		boolean updateVal = service.upload(vo, request);

		if (updateVal)
			map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else
			map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);

		map.put("result", updateVal);
		return map;
	}


	/**
	 * 기업회원 회원 목록
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/members/{seq}", method = RequestMethod.GET)
	public String members(Model model, @PathVariable("seq") int seq,
			@AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/members - seq : " + seq);

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno

		// boolean isUserNo = false;
		System.out.println("기업회원 상세");
		System.out.println("userno ???" + loginUserData.getEnterpriseno() + "대표계정 여부" + loginUserData.getRepresentat());

		boolean isUserNo = false;

		if (loginUserData == null) {
			isUserNo = false;
		} else {
			if (loginUserData.getEnterpriseno() == seq) {
				isUserNo = true;
			} else {
				isUserNo = false;
			}
		}

		UsersDetail vo = new UsersDetail();

		vo.setEnterpriseno(seq);

		vo.setUserat(0); // 승인 대기
		List<Users> users = service.getMembersList(vo); // 승인 대기 회원 목록
		model.addAttribute("users", users);

		vo.setUserat(1); // 승인
		users = service.getMembersList(vo); // 승인 회원 목록
		model.addAttribute("atusers", users);

		vo.setUserat(3); // 비활성
		users = service.getMembersList(vo); // 비활성 회원 목록
		model.addAttribute("unatusers", users);

		model.addAttribute("isMypage", isUserNo); // 내 정보 유무
		model.addAttribute("enterpriseno", seq); // 페이지 번호

		return "/enterprises/members";
	}


	/**
	 * 기업 맴버 승인/거절
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/updateUserat", method = RequestMethod.POST)
	public HashMap<String, Object> updateUserat(Model model, UsersDetail vo) throws Exception {
		if (LOG_URL)
			logger.info(" -- url : /enterprises/updateUserat - UsersDetail : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		// int enterpriseno = 4;
		// vo.setEnterpriseno(enterpriseno);
		System.out.println("변경할려는 userno => " + vo.getUserno());
		System.out.println("변경하려는 값? " + vo.getActiveat());
		vo.setRepresentat(2);// 회사의 하위 멤버 :2

		boolean updateVal = service.updateUserat(vo);

		if (updateVal)
			map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else
			map.put("message", CodeMessage.ERROR_000004_정보가_잘못_입력되었습니다__확인_후_다시_시도해_주세요_);

		map.put("updateVal", updateVal);
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
		if (LOG_URL)
			logger.info(" -- url : /enterprises/getScoregraph");

		HashMap<String, Object> map = new HashMap<String, Object>();
		Integer enterpriseno = Integer.valueOf(req.getParameter("enterpriseno"));

		if (enterpriseno != null) {
			String list = service.getScoregraph(enterpriseno);
			map.put("list", list);
			logger.info("---------- list : " + list);
		}

		return map;
	}

}