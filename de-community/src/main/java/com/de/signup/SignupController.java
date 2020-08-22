package com.de.signup;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.de.user.Users;
import com.de.user.UsersDetail;

@Controller
@RequestMapping(value = "/signup")
public class SignupController {
    @Autowired
	SignupService service;
    @Autowired
    SignupRepository sr;

    @ResponseBody
	@RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST)
    public int VerifyRecaptcha(HttpServletRequest request) {
		//Recaptcha 서버단 시크릿 키
        VerifyRecaptcha.setSecretKey("6LeS16wZAAAAAEXib5WsF1ynZt5NSSPBS5uj-GWh");
        String gRecaptchaResponse = request.getParameter("recaptcha");
      
        System.out.println(gRecaptchaResponse);
        //0 = 성공, 1 = 실패, -1 = 오류
        try {
            if(VerifyRecaptcha.verify(gRecaptchaResponse))
                return 0;
            else return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }
	
	// 회원가입 페이지로 이동
		@RequestMapping(value = "/signup")
		public String signUpViewUsers(Model model, @PageableDefault Pageable pageable) {
			System.out.println("----------users sign Up----------");
		
			return "/users/signup";
		}
		
	
	// 파트너사 회원가입 페이지로 이동
	@RequestMapping(value = "/partnerSignup")
	public String signUpViewPartners(Model model, @PageableDefault Pageable pageable) {
		System.out.println("---------partners sign Up----------");
	
		return "/users/partnerSignup";
	}
	
	@RequestMapping(value = "/checkIdDuplication")
	@ResponseBody
	public String checkIdDuplication(HttpServletRequest request, Users vo, Model model) {
	String chk = null;
	System.out.println("아이디 중복체크---> "+vo.getUserId());
	
	boolean idchk = service.idCheck(vo);
	
	if(idchk==false) {
		chk="사용가능한 아이디입니다";
	}else{
		chk="중복된 아이디입니다";
	}
	System.out.println(chk);		
		return chk;
	}

	@RequestMapping(value = "/checkBizNoDuplication")
	@ResponseBody
	public int checkBizNoDuplication(HttpServletRequest request, Users vo, UsersDetail uvo, Model model) {
	int chkBiz = 0;
	System.out.println("사업자 번호 중복체크---> "+uvo.getEnterpriseNo());

	boolean bizNochk = service.bizNoCheck(uvo);
	
	if(bizNochk==false) {
		chkBiz=1;
	}else{
		chkBiz=0;
	}
	System.out.println(chkBiz);		
		return chkBiz;
	}	
	
	//일반 유저 회원가입
	@RequestMapping(value = "/signup.proc", method = RequestMethod.POST)
	public String signUpProc(Model model, Users vo, UsersDetail uvo, HttpServletRequest request) {
		System.out.println("----------sign Up Proc----------");

		System.out.println("vo id==>" + vo.getUserId());
		System.out.println("vo email==>" + vo.getUserEmail());
		System.out.println("vo pw==>" + vo.getUserPassword());	
		
		String id = vo.getUserId();
		String email = vo.getUserEmail();
		String pw = vo.getUserPassword();
		
			try {
				 service.save(vo);
				 if(vo.getUserId() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserNo(vo.getUserNo());
					 uvo.setActiveAt(0);//setActiveAt 0이면 활성화(default), 1이면 비활성호된 계정
					 service.save(uvo);
				 }
			} catch (Exception e) {
				System.out.println("저장 실패!");
				e.printStackTrace();	
			}

			return "redirect:/login";
	}

	//파트너사 회원가입
	@RequestMapping(value = "/signupForPartner.proc")
	@ResponseBody
	public String signUpForPartnerProc(Model model, Users vo, UsersDetail uvo, HttpServletRequest request) {
		System.out.println("----------파트너사 sign Up Proc----------");
		String retVal="aa";

		System.out.println("vo id==>" + vo.getUserId());
		System.out.println("vo email==>" + vo.getUserEmail());
		System.out.println("vo pw==>" + vo.getUserPassword());	
		System.out.println("enterpriseNo-->" + uvo.getEnterpriseNo());
		
		if(uvo.getEnterpriseNo() != null) {
			try {
				 service.save(vo);
				 if(vo.getUserId() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserNo(vo.getUserNo());
					 service.save(uvo);
					 retVal="S";

				 }
			} catch (Exception e) {
				System.out.println("저장 실패!");
				e.printStackTrace();	
			}
		} else {
			System.out.println("사업자 번호 공란");

		}
		return retVal;

	}	
	
}
