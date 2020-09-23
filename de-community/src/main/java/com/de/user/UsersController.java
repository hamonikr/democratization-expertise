package com.de.user;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.de.answer.Answers;
import com.de.cmmn.util.CodeMessage;
import com.de.enterprise.Enterprises;
import com.de.login.service.SecurityMember;
import com.de.question.Questions;
import com.de.wiki.Wiki;


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
	@RequestMapping(value="/activity/{seq}", method=RequestMethod.GET)
	public String dashboard(Model model, @PathVariable("seq") int seq, @AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/activity - seq : " + seq);

		boolean isUserNo = false;
		
		if ( loginUserData == null ) {
			isUserNo = false;
		} else {
			if( loginUserData.getUserno() == seq ) {
				isUserNo = true;
			}
		}
		
		Optional<Users> users = usersService.findById(seq);
		Optional<Enterprises> enterprise = usersService.findEnterpriseNo(seq);
		
		// 질문
		int qCnt = usersService.cntQuestionsById(seq);
		Page<Questions> qList = usersService.findQuestionsByUserno(seq);
		
		// 답변
		int aCnt = usersService.cntAnswerById(seq);
		Page<Answers> aList = usersService.findAnswerByUserno(seq);
		
		// 태그 n 위키
		Wiki vo = new Wiki();
		vo.setUserno(seq);
		
		// 태그
		vo.setSection("t");
		int tCnt = usersService.cntTagAndWikiById(vo);
		List<Wiki> tList = usersService.findTagAndWikiByUserno(vo);
		
		// 위키
		vo.setSection("h");
		int wCnt = usersService.cntTagAndWikiById(vo);
		List<Wiki> wList = usersService.findTagAndWikiByUserno(vo);
		
		if(LOG_URL) {
			logger.info(" ------ qCnt : " + qCnt);
			logger.info(" ------ qList Content : " + qList.getContent());
			logger.info(" ------ aCnt : " + aCnt);
			logger.info(" ------ aList Content : " + aList.getContent());
			logger.info(" ------ tCnt : " + tCnt);
			logger.info(" ------ tList Content : " + tList);
			logger.info(" ------ wCnt : " + wCnt);
			logger.info(" ------ wList Content : " + wList);
		}
		
		System.out.println("1==========++"+ users.get().getUserprofileimg());
		model.addAttribute("user", users.orElse(null));	// 프로필 정보
		model.addAttribute("isMypage", isUserNo);		// 내 정보 유무
		model.addAttribute("enterprise", enterprise.orElse(null));	// 회사명 정보
		
		model.addAttribute("qCnt", qCnt);					// 질문 전체 수
		model.addAttribute("qList", qList.getContent());	// 질문 목록
		
		model.addAttribute("aCnt", aCnt);					// 답변 전체 수
		model.addAttribute("aList", aList.getContent());	// 답변 목록
		
		model.addAttribute("tCnt", tCnt);		// 태그 전체 수
		model.addAttribute("tList", tList);	// 태그 목록
		
		model.addAttribute("wCnt", wCnt);		// 위키 전체 수
		model.addAttribute("wList", wList);	// 위키 목록
//		model.addAttribute("tab", tab);

		return "/users/activity";
	}
	
	/**
	 * 사용자 목록
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String userList(@RequestParam Map<String, String> params,  Model model, @PageableDefault Pageable pageable) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/list - pageable : " + pageable);
		Page<Users> list = usersService.findAll(pageable);
		
		model.addAttribute("paging", list);
		model.addAttribute("data", list.getContent());
		
		return "/users/list";
	}

	/**
	 * 사용자 상세 정보
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/profile/{seq}", method=RequestMethod.GET)
	public String modify(Model model, @PathVariable("seq") int seq, @AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/profile - seq : " + seq);
		
		boolean isUserNo = false;
		
		Optional<Users> user = usersService.findById(seq);
		Optional<Enterprises> enterprise = usersService.findEnterpriseNo(seq);
		
		logger.info(" ------ user : " + user);
		logger.info(" ------ enterprise : " + enterprise);
		
		if ( loginUserData == null ) {
			isUserNo = false;
		} else {
			if( loginUserData.getUserno() == seq ) {
				isUserNo = true;
			}
		}
		
		
		model.addAttribute("user", user.orElse(null));	// 프로필 정보
		model.addAttribute("isMypage", isUserNo );	// 내 정보 유무
		model.addAttribute("enterprise", enterprise.orElse(null));	// 회사명 정보
		
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
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(Model model, Users vo, UsersDetail userDetail) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/modify - user : " + vo + " // detail : " + userDetail);
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
	@ResponseBody
	@RequestMapping(value="/modifyPw", method=RequestMethod.POST)
	public HashMap<String, Object> modifyPassword(Model model, UserPwVO vo, @AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/modify - UserPwVO : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		vo.setUserno(loginUserData.getUserno());
		
		boolean updateVal = usersService.updateUserPw(vo);
		
		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else map.put("message", CodeMessage.MSG_100009_비밀번호가_일치하지_않습니다__다시_확인해주세요_);
		
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
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	public HashMap<String, Object> upload(MultipartHttpServletRequest request, @AuthenticationPrincipal SecurityMember loginUserData) throws Exception{
		if(LOG_URL) logger.info(" -- url : /users/upload - request : " + request);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		Users vo = new Users();
		vo.setUserno(loginUserData.getUserno());
		
		boolean updateVal = usersService.upload(vo, request);
		
		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);
		
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
	@RequestMapping(value="/getEnterList", method=RequestMethod.POST)
	public HashMap<String, Object> getEnterList(String enterName) throws Exception{
		
		if(LOG_URL) logger.info(" -- url : /users/getEnterList - enterName : " + enterName);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		 List<Enterprises> list= usersService.getEnterList(enterName);
		System.out.println("list-----------" + list);
//		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
//		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);
		
		map.put("list", list);
		return map;
	}
}
