package com.de.enterprise;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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

import com.de.cmmn.util.CodeMessage;
import com.de.login.service.SecurityMember;
import com.de.user.Users;
import com.de.user.UsersDetail;


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
	EnterprisesRepository repository;

	/**
	 * 기업회원 활동정보 대시보드
	 * @param model
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/activity/{seq}", method=RequestMethod.GET)
	public String dashboard(Model model, @PathVariable("seq") int seq, @AuthenticationPrincipal SecurityMember loginUserData) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/activity - seq : " + seq);

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
//		int userSeq = 4;
		
		boolean isUserNo = false;
		
		if ( loginUserData == null ) {
			isUserNo = false;
		} else {
			if( loginUserData.getEnterpriseno() == seq ) {
				isUserNo = true;
			}else {
				isUserNo = false;	
			}
		}
		System.out.println("loginUserData.getUserno()=========+++++"+loginUserData.getEnterpriseno() );
		Optional<Enterprises> enterprises = service.findById(seq);
		
UsersDetail vo = new UsersDetail();
		
		vo.setEnterpriseno(seq);
		
		vo.setUserat(0);	// 승인 대기
		List<Users> users = service.getMembersList(vo);	// 승인 대기 회원 목록
		model.addAttribute("users", users);
		
		vo.setUserat(1);	// 승인
		users = service.getMembersList(vo);	// 승인 회원 목록
		model.addAttribute("atusers", users);
		
		vo.setUserat(3);	// 비활성
		users = service.getMembersList(vo);	// 비활성 회원 목록
		model.addAttribute("unatusers", users);
		
//		model.addAttribute("isMypage", seq == enterpriseno);	// 내 정보 유무
//		model.addAttribute("enterpriseno", seq);	// 페이지 번호
		
		
		model.addAttribute("enterprise", enterprises.orElse(null));	// 프로필 정보
		model.addAttribute("isMypage", isUserNo);		// 내 정보 유무

		return "/enterprises/activity";
	}
	
	/**
	 * 기업회원 목록
	 * @param model
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String enterprisesList(Model model, @PageableDefault Pageable pageable) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/list - pageable : " + pageable);
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
	@RequestMapping(value="/profile/{seq}", method=RequestMethod.GET)
	public String modify(Model model, @PathVariable("seq") int seq) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/profile - seq : " + seq);
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 사용자 seq
		int enterSeq = 4;
		
		Optional<Enterprises> enterprise = service.findById(seq);
		
		logger.info(" ------ enterprise : " + enterprise);
		
		if ( ! enterprise.isPresent()) {
			return "redirect:/enterprises/list";
		}
		
		model.addAttribute("enter", enterprise.orElse(null));	// 파트너사 정보
		model.addAttribute("isMypage", seq == enterSeq);	// 내 정보 유무
		
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
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(Model model, Enterprises vo) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/modify - Enterprises : " + vo);
		service.updateEnterprises(vo);
		return "redirect:/enterprises/profile/" + vo.getEnterpriseno();
	}
	
	/**
	 *  기업회원 비밀번호 수정
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/modifyPw", method=RequestMethod.POST)
	public HashMap<String, Object> modifyPassword(Model model, EnterprisePwVO vo) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/modify - EnterprisePwVO : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		int enterpriseno = 4;
		vo.setEnterpriseno(enterpriseno);
		
		boolean updateVal = service.updateEnterprisePw(vo);
		
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
		if(LOG_URL) logger.info(" -- url : /enterprises/upload - request : " + request);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		int enterpriseno = 4;
		
		Enterprises vo = new Enterprises();
		vo.setEnterpriseno(enterpriseno);
		
		boolean updateVal = service.upload(vo, request);
		
		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else map.put("message", CodeMessage.MSG_000024_변경_중_오류가_발생하였습니다_);
		
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
	@RequestMapping(value="/members/{seq}", method=RequestMethod.GET)
	public String members(Model model, @PathVariable("seq") int seq) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/members - seq : " + seq);

		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		int enterpriseno = 4;
		UsersDetail vo = new UsersDetail();
		
		vo.setEnterpriseno(seq);
		
		vo.setUserat(0);	// 승인 대기
		List<Users> users = service.getMembersList(vo);	// 승인 대기 회원 목록
		model.addAttribute("users", users);
		
		vo.setUserat(1);	// 승인
		users = service.getMembersList(vo);	// 승인 회원 목록
		model.addAttribute("atusers", users);
		
		vo.setUserat(3);	// 비활성
		users = service.getMembersList(vo);	// 비활성 회원 목록
		model.addAttribute("unatusers", users);
		
		model.addAttribute("isMypage", seq == enterpriseno);	// 내 정보 유무
		model.addAttribute("enterpriseno", seq);	// 페이지 번호

		return "/enterprises/members";
	}
	
	/**
	 *  기업 맴버 승인/거절
	 * @param model
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateUserat", method=RequestMethod.POST)
	public HashMap<String, Object> updateUserat(Model model, UsersDetail vo) throws Exception {
		if(LOG_URL) logger.info(" -- url : /enterprises/updateUserat - UsersDetail : " + vo);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 로그인 상태 확인 - 로그인 기능 구현 확인후 추가 예정
		// session 에서 seq 정보 추출
		// 임시 - 기업회원 enterpriseno
		//int enterpriseno = 4;
		//vo.setEnterpriseno(enterpriseno);
		System.out.println("변경할려는 userno => "+vo.getUserno());
		System.out.println("변경하려는 값? "+vo.getActiveat());
		vo.setRepresentat(2);//회사의 하위 멤버 :2
		
		boolean updateVal = service.updateUserat(vo);
		
		
		if(updateVal) map.put("message", CodeMessage.MSG_000014_변경_되었습니다_);
		else map.put("message", CodeMessage.ERROR_000004_정보가_잘못_입력되었습니다__확인_후_다시_시도해_주세요_);
		
		map.put("updateVal", updateVal);
		return map;
	}
}