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

import com.de.enterprise.Enterprises;
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
		
			return "/login/signup";
		}
		
	
	// 파트너사 회원가입 페이지로 이동
	@RequestMapping(value = "/partnerSignup")
	public String signUpViewPartners(Model model, @PageableDefault Pageable pageable) {
		System.out.println("---------partners sign Up----------");
	
		return "/login/partnerSignup";
	}
	
	@RequestMapping(value = "/checkIdDuplication")
	@ResponseBody
	public String checkIdDuplication(HttpServletRequest request, Users vo, Model model) {
	String chk = null;
	System.out.println("아이디 중복체크---> "+vo.getUserid());
	
	boolean idchk = service.idCheck(vo);
	
	if(idchk==false) {
		chk="사용가능한 아이디입니다";
	}else{
		chk="중복된 아이디입니다";
	}
	
	System.out.println(chk);		
		return chk;
	}
	
	
	@RequestMapping(value = "/checkEmailDuplication")
	@ResponseBody
	public String checkEmailDuplication(HttpServletRequest request, Users vo, Model model) {
	String chk = null;
	System.out.println("이메일 중복체크---> " + vo.getUseremail());
	
	boolean emchk = service.emCheck(vo);
	
	if(emchk==false) {
		chk="";
	}else{
		chk="사용중인 이메일입니다";
	}
	
	System.out.println(chk);		
		return chk;
	}
	

	@RequestMapping(value = "/checkBizNoDuplication")
	@ResponseBody
	public int checkBizNoDuplication(HttpServletRequest request, Enterprises evo, Model model) throws Exception {
		
	int chkBiz = 0;
	System.out.println("사업자 번호 중복체크---> "+evo.getEnterprisebizno());

//	boolean bizNochk = service.bizNoCheck(uvo);
	Integer bizNochk = service.bizNoCheck(evo);
	// 존재하면 : 1 반환, 존재하지 않으면 :0
	if(bizNochk==0) {
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

		System.out.println("vo id==>" + vo.getUserid());
		System.out.println("vo email==>" + vo.getUseremail());
		System.out.println("vo pw==>" + vo.getUserpassword());	
		
		String id = vo.getUserid();
		String email = vo.getUseremail();
		String pw = vo.getUserpassword();
		
			try {
				 service.save(vo);
				 if(vo.getUserid() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserno(vo.getUserno());
					 uvo.setActiveat(0);//setActiveAt 0이면 활성화(default), 1이면 비활성호된 계정
					 service.saveDetail(uvo);
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
	public String signUpForPartnerProc(Model model, Users vo, Enterprises evo ,UsersDetail uvo, HttpServletRequest request) {
		System.out.println("----------파트너사 sign Up Proc----------");
		String retVal="aa";

		System.out.println("vo id==>" + vo.getUserid());
		System.out.println("vo email==>" + vo.getUseremail());
		System.out.println("vo pw==>" + vo.getUserpassword());	
		System.out.println("enterprisebizno-->" +evo.getEnterprisebizno());
		System.out.println("username----" + vo.getUsername());
		
		if(evo.getEnterprisebizno() != null) {
			try {
				// 사용자 정보 저장.
				 service.save(vo);
				 
				 evo.setEnterprisename(vo.getUsername());// 회사명
				 evo.setRepresentat(1);
				 evo.setUserno(vo.getUserno());
				 
				 System.out.println("entp----" + evo.toString());
				 // 기업정보 저장.
				 service.saveEnterprisebizno(evo);
				 if(vo.getUserid() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserno(vo.getUserno());
					 uvo.setEnterpriseno(service.getEnterpriseno(evo));
					 service.saveDetail(uvo);
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
