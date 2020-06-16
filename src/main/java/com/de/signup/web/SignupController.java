package com.de.signup.web;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.de.login.service.SecurityMember;
import com.de.signup.service.SignupService;
import com.de.signup.service.vo.CompanyVO;
import com.de.signup.service.vo.UserMngrVO;


@Controller
@RequestMapping("/signup")
public class SignupController {

	@Autowired
	private SignupService signUpService;
	
	@Autowired
	private MessageSource messageSource;

	// 로그인 페이지에서 회원가입 페이지로 이동
	@RequestMapping("/addForm.ivs")
	public String signup(HttpServletRequest request, ModelMap model) throws Exception {
		System.out.println("회원가입 페이지 이동확인");

		return "/signup/signupAdd";
	}

	@RequestMapping(value = "/addForm.proc")
	public String addFormProc(HttpServletRequest request, CompanyVO vo, ModelMap model) throws Exception {

		System.out.println("가입신청 클릭시 db로 저장이 되는지 확인 ");
		System.out.println(">>> 들어가는 데이터 확인 " + vo.toString());

		String pstate[] = { "Y", "R" };// Y:승인, R:승인요청
		String user_role = "R";

		vo.setProc_stat(pstate[1]); // 현재는 디폴트로 R 값 넣기
		vo.setUser_role(user_role); // 대표 담당자 회원가입 페이지임으로 - R(Representive)

		int result1 = signUpService.bizInfoSave(vo);

		if (result1 == 1) {
			System.out.println("회사정보 DB저장 완료");
			result1 = signUpService.userInfoSave(vo);
			if (result1 == 1) {
				System.out.println("유저정보 DB저장 완료");
			} else {
				System.out.println("유저정보 DB저장 실패");
			}
		} else {
			System.out.println("회사정보 DB저장 실패");
		}
		return "/login/login";

	}

	@RequestMapping(value = "/addSubUserProc.proc")
	@ResponseBody
	public Map<Object, Object> addSubUserProc(HttpServletRequest request, Map map, CompanyVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {

		
		Map<Object, Object> retMap = new HashMap<Object, Object>();
		vo.setBizcd(user.getBizcd());

		// 추가 담당자의 핸드폰 번호는 추후에 본인이 설정하도록 널값
		vo.setUser_hp(null);
		String pstate[] = { "Y", "N", "R" };// Y:승인, N:반려, R:승인요청
		String user_role = "S";

		vo.setProc_stat(pstate[0]); // 디폴트로 Y 값 넣기
		vo.setUser_role(user_role); // 대표 담당자 회원가입 페이지임으로 - S(Substitute)

		System.out.println("======addSubUserProc 동작 확인=======");

		int result = 0;
		if (chk_addUser == 0) {
			if (vo.getUser_id() == "") {
				System.out.println("아이디가 공백");
				System.out.println("등록실패!");
				retMap.put("success", "N");
				retMap.put("msg", "아이디를 입력해주세요");
			} else {
				System.out.println("입력값 전달 확인 " + "아이디 :  " + vo.getUser_id() + "\n" + "비밀번호 :  " + vo.getUser_passwd1()
						+ "\n" + "이름 :  " + vo.getUser_nm() + "\n" + "직급 :  " + vo.getUser_rank() + "\n" + "이메일 :  "
						+ vo.getUser_email() + "\n" + "핸드폰 번호 : " + vo.getUser_hp());

				result = signUpService.userInfoSave(vo);
				if (result == 1) {
					System.out.println("추가 유저정보 DB저장 완료");
					retMap.put("success", "Y");
					retMap.put("msg", "저장이 완료되었습니다!");
				} else {
					System.out.println("추가 유저정보 DB저장 실패");
					retMap.put("success", "N");
					retMap.put("msg", "등록중 오류가 발생하였습니다. 제시도후 같은 오류가 발생시 관리자에게 문의바랍니다.!");
				}
			}
		} else {
			System.out.println("등록실패!");
			retMap.put("success", "N");
			retMap.put("msg", "등록중 오류가 발생하였습니다. 제시도후 같은 오류가 발생시 관리자에게 문의바랍니다.!");
		}

		return retMap;

	}

	@RequestMapping("/biznoCheck.proc")
	@ResponseBody
	public Map<Object, Object> biznoChk(CompanyVO vo) throws Exception {
		Map<Object, Object> bizmap = new HashMap<Object, Object>();
		int count = 0;
		count = signUpService.biznoCheck(vo);
		bizmap.put("cnt", count);

		return bizmap;
	}

	@RequestMapping("/userIDCheck.proc")
	@ResponseBody
	public Map<Object, Object> userIDChk(CompanyVO vo) throws Exception {
		int count_user = 0;
		Map<Object, Object> idmap = new HashMap<Object, Object>();

		count_user = signUpService.userIDCheck(vo);
		idmap.put("cnt", count_user);

		return idmap;
	}

	int chk_addUser = 0;

	// 추가 담당자 중복확인
	@RequestMapping("/addUserIDCheck.proc")
	@ResponseBody
	public Map<Object, Object> addUserIDChk(CompanyVO vo) throws Exception {
		System.out.println("===========addUser_id 중복체크 컨트롤러 페이지 불려오는지 확인");

		Map<Object, Object> addIdmap = new HashMap<Object, Object>();

		chk_addUser = signUpService.addUserIDCheck(vo);

		if (chk_addUser == 1) {
			System.out.println("이미 존재하는 아이디!");
			addIdmap.put("cnt", chk_addUser);
		} else {
			if (vo.getUser_id() != "") {
				System.out.println("사용가능한 아이디!");
				addIdmap.put("cnt", chk_addUser);
			} else {
				System.out.println("아이디 공백이여서 중복조회실패!");
			}
		}
		String checkVal = vo.getUser_id();
		System.out.println("유저아이디 체크 입력값 >> " + checkVal);

		return addIdmap;
	}

	// 회사정보 관리 페이지로 이동
	@RequestMapping("/bizEditForm.ivs")
	public String edit(HttpSession session, HttpServletRequest request, CompanyVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {
		System.out.println("회원정보 수정 페이지 이동확인");
		vo.setBizcd(user.getBizcd());
		vo = signUpService.getBizInfo(vo);

		int strLen = vo.getTele().length();
		System.out.println("전화번호 출력" + vo.getTele() + " " + strLen + " " + vo.getTele().substring(0, 2));

		int strLenFax = vo.getFax().length();

		switch (strLen) {
		case 9:
			vo.setTele1(vo.getTele().substring(0, 2));
			vo.setTele2(vo.getTele().substring(2, 5));
			vo.setTele3(vo.getTele().substring(5, 9));
			break;
		case 10:
			if (vo.getTele().substring(0, 2).equals("02")) {
				vo.setTele1(vo.getTele().substring(0, 2));
				vo.setTele2(vo.getTele().substring(2, 6));
				vo.setTele3(vo.getTele().substring(6, 10));
			} else {
				vo.setTele1(vo.getTele().substring(0, 3));
				vo.setTele2(vo.getTele().substring(4, 6));
				vo.setTele3(vo.getTele().substring(7, 10));
			}

			break;
		case 11:
			vo.setTele1(vo.getTele().substring(0, 3));
			vo.setTele2(vo.getTele().substring(3, 7));
			vo.setTele3(vo.getTele().substring(7, 11));

			break;
		default:
			System.out.println("input error~~~");
		}

		switch (strLenFax) {
		case 9:
			vo.setFax1(vo.getFax().substring(0, 2));
			vo.setFax2(vo.getFax().substring(2, 5));
			vo.setFax3(vo.getFax().substring(5, 9));
			break;
		case 10:
			if (vo.getFax().substring(0, 2).equals("02")) {
				vo.setFax1(vo.getFax().substring(0, 2));
				vo.setFax2(vo.getFax().substring(2, 6));
				vo.setFax3(vo.getFax().substring(6, 10));
			} else {
				vo.setFax1(vo.getFax().substring(0, 3));
				vo.setFax2(vo.getFax().substring(4, 6));
				vo.setFax3(vo.getFax().substring(7, 10));
			}

			break;
		case 11:
			vo.setFax1(vo.getFax().substring(0, 3));
			vo.setFax2(vo.getFax().substring(3, 7));
			vo.setFax3(vo.getFax().substring(7, 11));
		default:
			System.out.println("input error~~~");
		}

		model.addAttribute("bizResult", vo);

		return "signup/bizEdit";
	}

	@RequestMapping("/userEditForm.ivs")
	public String userEdit(HttpSession session, HttpServletRequest request, UserMngrVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user, @ModelAttribute(value="procVal") String procVal ) throws Exception {

		vo.setUser_id(user.getUsername());
		vo.setBizcd(user.getBizcd());


		vo = signUpService.getUserInfo(vo);

		int strLen = vo.getUser_hp().length();
		System.out.println("전화번호 출력" + vo.getUser_hp() + " " + strLen + " " + vo.getUser_hp().substring(0, 2));

		switch (strLen) {
		case 10:
			vo.setUser_hp1(vo.getUser_hp().substring(0, 3));
			vo.setUser_hp2(vo.getUser_hp().substring(3, 6));
			vo.setUser_hp3(vo.getUser_hp().substring(6, 10));
			break;
		case 11:
			vo.setUser_hp1(vo.getUser_hp().substring(0, 3));
			vo.setUser_hp2(vo.getUser_hp().substring(3, 7));
			vo.setUser_hp3(vo.getUser_hp().substring(7, 11));
		default:
			System.out.println("input error~~~");
		}

		model.addAttribute("userResult", vo);

		vo.setBizcd(user.getBizcd());

		List<UserMngrVO> list = signUpService.getAddUserInfo(vo);
		model.addAttribute("addList", list);
		
//		String procVal = request.getParameter("procVal");
		System.out.println("procVal==="+procVal);
		model.addAttribute("procVal", procVal);
		
		
		

		return "signup/userEdit";
	}

	@RequestMapping("/subUserEditForm.ivs")
	public String subUserEdit(HttpSession session, HttpServletRequest request, UserMngrVO vo, CompanyVO cvo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		

		vo.setUser_id(user.getUsername());
		vo.setBizcd(user.getBizcd());

		System.out.println("user>>>>" + user.getBizcd());
		System.out.println("bizcd  vo>>>>" + vo.getBizcd());

		vo = signUpService.getUserInfo(vo);

		System.out.println("vo >>>>" + vo.toString());

		
		int strLen = vo.getUser_hp().length();
		if(strLen != 0) {
		System.out.println("전화번호 출력" + vo.getUser_hp() + " " + strLen + " " + vo.getUser_hp().substring(0, 2));

		switch (strLen) {
		case 10:
			vo.setUser_hp1(vo.getUser_hp().substring(0, 3));
			vo.setUser_hp2(vo.getUser_hp().substring(3, 6));
			vo.setUser_hp3(vo.getUser_hp().substring(6, 10));
			break;
		case 11:
			vo.setUser_hp1(vo.getUser_hp().substring(0, 3));
			vo.setUser_hp2(vo.getUser_hp().substring(3, 7));
			vo.setUser_hp3(vo.getUser_hp().substring(7, 11));
		default:
			System.out.println("input error~~~");
		} 
		
		}else {
		    System.out.println("추가 담당자 초기 로그인시 또는 핸드폰 번호가 입력되어 있지 않을때");
		} 

		model.addAttribute("userResult", vo);

		// 회사정보 불러오기
		cvo.setBizcd(user.getBizcd());
		cvo = signUpService.getBizInfo(cvo);

		int strLenBiz = cvo.getTele().length();
		System.out.println("전화번호 출력" + cvo.getTele() + " " + strLen + " " + cvo.getTele().substring(0, 2));

		int strLenFaxBiz = cvo.getFax().length();

		switch (strLenBiz) {
		case 9:
			cvo.setTele1(cvo.getTele().substring(0, 2));
			cvo.setTele2(cvo.getTele().substring(2, 5));
			cvo.setTele3(cvo.getTele().substring(5, 9));
			break;
		case 10:
			if (cvo.getTele().substring(0, 2).equals("02")) {
				cvo.setTele1(cvo.getTele().substring(0, 2));
				cvo.setTele2(cvo.getTele().substring(2, 6));
				cvo.setTele3(cvo.getTele().substring(6, 10));
			} else {
				cvo.setTele1(cvo.getTele().substring(0, 3));
				cvo.setTele2(cvo.getTele().substring(4, 6));
				cvo.setTele3(cvo.getTele().substring(7, 10));
			}

			break;
		case 11:
			cvo.setTele1(cvo.getTele().substring(0, 3));
			cvo.setTele2(cvo.getTele().substring(3, 7));
			cvo.setTele3(cvo.getTele().substring(7, 11));

			break;
		default:
			System.out.println("input error~~~");
		}

		switch (strLenFaxBiz) {
		case 9:
			cvo.setFax1(cvo.getFax().substring(0, 2));
			cvo.setFax2(cvo.getFax().substring(2, 5));
			cvo.setFax3(cvo.getFax().substring(5, 9));
			break;
		case 10:
			if (cvo.getFax().substring(0, 2).equals("02")) {
				cvo.setFax1(cvo.getFax().substring(0, 2));
				cvo.setFax2(cvo.getFax().substring(2, 6));
				cvo.setFax3(cvo.getFax().substring(6, 10));
			} else {
				cvo.setFax1(cvo.getFax().substring(0, 3));
				cvo.setFax2(cvo.getFax().substring(4, 6));
				cvo.setFax3(cvo.getFax().substring(7, 10));
			}

			break;
		case 11:
			cvo.setFax1(cvo.getFax().substring(0, 3));
			cvo.setFax2(cvo.getFax().substring(3, 7));
			cvo.setFax3(cvo.getFax().substring(7, 11));
		default:
			System.out.println("input error~~~");
		}
		model.addAttribute("bizResult", cvo);
		
		return "signup/subUserEdit";
	}

	// 회사 정보 업데이트
	@RequestMapping(value = "/bizEditForm.proc")
	public String bizEditFormProc(HttpServletRequest request, CompanyVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {

		vo.setBizcd(user.getBizcd());

		int result = signUpService.bizInfoUpdate(vo);

		if (result == 1) {
			System.out.println("회사정보 업데이트 완료");
			System.out.println("업데이트 된 회사정보값 ===========>>>" + vo.toString());

		} else {
			System.out.println("회사정보 업데이트 실패");
		}

		return "redirect:bizEditForm.ivs";
	}

	// 대표 담당자 정보 업데이트
	@RequestMapping(value = "/userEditForm.proc", method = { RequestMethod.POST })
	public String editFormProc(HttpServletRequest request, UserMngrVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user , RedirectAttributes redirect) throws Exception {

		vo.setUser_id(user.getUsername());
		vo.setBizcd(user.getBizcd());


		Map<String, Object> map = new HashMap<String,Object>();
		
		int result = 0;
		String pw = vo.getUser_passwd();
		vo.setUser_nm(vo.getUser_nm().trim());
		
		if (pw.isEmpty() != true) {
			result = signUpService.userInfoUpdate(vo);
			if (result == 1) {
				redirect.addFlashAttribute("procVal", "Y");
			} else {
				redirect.addFlashAttribute("procVal", "N");
			}

		} else {

			result = signUpService.userInfoUpdate_without_pw(vo);
			if (result == 1) {
				redirect.addFlashAttribute("procVal", "Y");
			} else {
				redirect.addFlashAttribute("procVal", "N");
			}
		}
		
		return "redirect:userEditForm.ivs";
	}
	

	// 추가 담당자 정보 업데이트
	@RequestMapping(value = "/updateAddUserInfo.proc", method = { RequestMethod.POST })
	public String updateAddUserInfo(HttpServletRequest request, UserMngrVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user, RedirectAttributes redirect) throws Exception {
		
		
		vo.setBizcd(user.getBizcd());


		int result = 0;
		String pw = vo.getUser_passwd();
		System.out.println("입략힌 비밀 번호 >>" + vo.getUser_passwd() + "<<");
		vo.setUser_nm(vo.getUser_nm().trim());
		if (pw.isEmpty() != true) {
			result = signUpService.userInfoUpdate(vo);
			if (result == 1) {
				System.out.println("담당자 정보 업데이트 완료 ");
				System.out.println("업데이트 된 담당자 정보값 ===========>>>" + vo.getUser_passwd());
				redirect.addFlashAttribute("procVal", "Y");
			} else {
				System.out.println("담당자 정보 업데이트 실패! ");
				redirect.addFlashAttribute("procVal", "N");
			}

		} else {

			result = signUpService.userInfoUpdate_without_pw(vo);
			if (result == 1) {
				System.out.println("패스워드가 null인 경우 패스워드만 제외하고 업데이트");
				System.out.println("담당자 정보 업데이트 완료 ");
				System.out.println("업데이트 이후 비밀 번호 " + vo.getUser_passwd());
				redirect.addFlashAttribute("procVal", "Y");

			} else {
				System.out.println("담당자 정보 업데이트 실패!");
				redirect.addFlashAttribute("procVal", "N");
			}
		}
		return "redirect:userEditForm.ivs";
	}

	// 추가 담당자 정보 업데이트
	@RequestMapping(value = "/subUserEditForm.proc")
	public String updateSubUserInfo(HttpServletRequest request, UserMngrVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user,  RedirectAttributes redirect) throws Exception {
		// 유저정보 업데이트
		System.out.println("vo ==>  user_hp" + vo.getUser_hp1()+ vo.getUser_hp2()+ vo.getUser_hp3());
		System.out.println("vo ==>"+ vo.getUser_email());
	
		int result = 0;
		
		String pw = vo.getUser_passwd();
		System.out.println("입력한 비밀 번호 >>" + vo.getUser_passwd() + "<<");
		vo.setUser_id(vo.getUser_id().trim());

		if (pw.isEmpty() != true) {
			result = signUpService.userInfoUpdate(vo);
			if (result == 1) {
				System.out.println("담당자 정보 업데이트 완료 ");
				System.out.println("업데이트 된 담당자 정보값 ===========>>>" + vo.getUser_passwd());
				//redirect.addFlashAttribute("procVal", "S");
				model.addAttribute("message", messageSource.getMessage("common.update.success", null, Locale.getDefault()));
				model.addAttribute("url", "subUserEditForm.ivs");

			} else {
				System.out.println("담당자 정보 업데이트 실패! ");
				//redirect.addFlashAttribute("procVal", "F");
				model.addAttribute("message", messageSource.getMessage("common.update.fail", null, Locale.getDefault()));
				model.addAttribute("url", "subUserEditForm.ivs");
			}

		} else {

			result = signUpService.userInfoUpdate_without_pw(vo);
			if (result == 1) {
				System.out.println("패스워드가 null인 경우 패스워드만 제외하고 업데이트");
				System.out.println("담당자 정보 업데이트 완료 ");
				System.out.println("업데이트 이후 비밀 번호 " + vo.getUser_passwd());
				//redirect.addFlashAttribute("procVal", "S");
				model.addAttribute("message", messageSource.getMessage("common.update.success", null, Locale.getDefault()));
				model.addAttribute("url", "subUserEditForm.ivs");

			} else {
				System.out.println("담당자 정보 업데이트 실패!");
				//redirect.addFlashAttribute("procVal", "F");
				model.addAttribute("message", messageSource.getMessage("common.update.fail", null, Locale.getDefault()));
				model.addAttribute("url", "subUserEditForm.ivs");
			}
		}
		return "cmmn/message";
	}

	// 추가 담당자 정보 삭제
	@RequestMapping(value = "/deleteAddUserInfo.proc", method = { RequestMethod.POST })
	public String deleteAddUserInfo(HttpServletRequest request, UserMngrVO vo, ModelMap model, RedirectAttributes redirect) throws Exception {

		System.out.println("삭제되는 열의 아이디==> " + vo.getUser_id());

		int result = signUpService.deleteAddUserInfo(vo);
		if (result == 1) {
			System.out.println("추가 담당자 정보 삭제 완료! ");
			redirect.addFlashAttribute("procVal", "YD");
		} else {
			System.out.println("추가 담당자 정보 삭제 실패 ");
			redirect.addFlashAttribute("procVal", "ND");
		}

		return "redirect:userEditForm.ivs";
	}

	// 활성상태 변경
	@ResponseBody
	@RequestMapping(value = "/updateUserActiveStatus.proc")
	public int updateUserActiveStatus(HttpServletRequest request, UserMngrVO vo, ModelMap model,
			@AuthenticationPrincipal SecurityMember user) throws Exception {
		System.out.println("vo======" + vo.toString());
		System.out.println("입력한 아이디 ===>" + vo.getUser_id());
		System.out.println("입력한 active_status ===>" + vo.getActive_status());

		String at = vo.getActive_status();
		System.out.println("at==>>>>" + at);
		int result = 0;

		if (at.equals("IA")) {
			System.out.println(" IA >> A 동작확인 ");
			vo.setActive_status("A");
			vo.setProc_stat("Y");// A되면 로그인 되도록 proc_stat 변경
			result = signUpService.updateUserActiveStatus(vo);

			if (result == 1) {
				System.out.println("활성값 변경 성공!");
			} else {
				System.out.println("활성값 변경 실패!");
			}

		} else if (at.equals("A")) {
			System.out.println(" A >> IA 동작확인 ");
			vo.setActive_status("IA");
			vo.setProc_stat("R"); // IA되면 로그인 안되도록 proc_stat 변경
			result = signUpService.updateUserActiveStatus(vo);

			if (result == 1) {
				System.out.println("활성값 변경 성공!");
			} else {
				System.out.println("활성값 변경 실패!");
			}
		} else {
			System.out.println("error~~~~!!!!!!");
		}

		return result;
	}
}
