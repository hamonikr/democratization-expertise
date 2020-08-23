package com.de.user;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.de.cmmn.util.CodeMessage;
import com.de.enterprise.Enterprises;


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
@RequestMapping(value = "/users")
public class UsersController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private final boolean LOG_URL = true;
	
	@Autowired
	UsersService service;

	@Autowired
	UsersRepository repository;

	/**
	 * 사용자 활동정보 대시보드
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dashboard/{seq}", method=RequestMethod.GET)
	public String dashboard(Model model, @PathVariable("seq") int seq) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/dashboard - seq : " + seq);

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int userSeq = 4;
		
		Optional<Users> users = service.findById(userSeq);
		model.addAttribute("result", users.orElse(null));	// 프로필 정보
		model.addAttribute("isMypage", seq == userSeq);		// 내 정보 유무

		return "/users/dashboard";
	}	
	
	/**
	 * 사용자 목록
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String userList(Model model, @PageableDefault Pageable pageable) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/list - pageable : " + pageable);
		Page<Users> list = service.findAll(pageable);

		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");

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
	@RequestMapping(value="/view/{seq}", method=RequestMethod.GET)
	public String modify(Model model, @PathVariable("seq") int seq) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/view - seq : " + seq);
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int userSeq = 4;
		
		Optional<Users> users = service.findById(seq);
		model.addAttribute("result", users.orElse(null));	// 프로필 정보
		model.addAttribute("isMypage", seq == userSeq);		// 내 정보 유무
		
		return "/users/view";
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
	public String modify(Model model, Users vo, boolean newslater) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/modify - user : " + vo + " // newslater : " + newslater);
		service.updateUser(vo, newslater);
		return "redirect:/users/view/" + vo.getUserNo();
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
	public HashMap<String, Object> modifyPassword(Model model, UserPwVO vo) throws Exception {
		if(LOG_URL) logger.info(" -- url : /users/modify - UserPwVO : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int userSeq = 4;
		vo.setUserNo(userSeq);
		
		boolean updateVal = service.updateUserPw(vo);
		
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
	public HashMap<String, Object> upload(MultipartHttpServletRequest request) throws Exception{
		if(LOG_URL) logger.info(" -- url : /users/upload - request : " + request);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int userSeq = 4;
		
		Users vo = new Users();
		vo.setUserNo(userSeq);
		
		boolean updateVal = service.upload(vo, request);
		
		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);
		
		map.put("result", updateVal);
		return map;
	}


	@ResponseBody
	@RequestMapping(value="/getEnterList", method=RequestMethod.POST)
	public HashMap<String, Object> getEnterList(String enterName) throws Exception{
		if(LOG_URL) logger.info(" -- url : /users/getEnterList - enterName : " + enterName);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		 List<Enterprises> list= service.getEnterList(enterName);
		
//		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
//		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);
		
		map.put("list", list);
		return map;
	}
}