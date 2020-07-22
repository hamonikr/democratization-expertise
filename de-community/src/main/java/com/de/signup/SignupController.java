package com.de.signup;

import java.io.IOException;

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
	
	// 파트너사 회원가입 페이지로 이동
	@RequestMapping(value = "/partnerSignup")
	public String signUpView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------sign Up----------");
	
		return "/login/partnerSignup";
	}
	
	
	//일반 유저 회원가입
	@RequestMapping(value = "/signup.proc", method = RequestMethod.POST)
	@ResponseBody
	public String signUpProc(Model model, Users vo, UsersDetail uvo, HttpServletRequest request) {
		String retVal = null;
		System.out.println("----------sign Up Proc----------");

		System.out.println("vo id==>" + vo.getUserId());
		System.out.println("vo email==>" + vo.getUserEmail());
		System.out.println("vo pw==>" + vo.getUserPassword());	
		
		String id = vo.getUserId();
		String pw = vo.getUserPassword();
		
		if(id != null && pw !=null) {
			try {
				 service.save(vo);
				 if(vo.getUserId() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserNo(vo.getUserNo());
					 service.save(uvo);
					 retVal = "S";
				 }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("저장 실패!");
				retVal = "F";
				e.printStackTrace();			
			}
		}
		return retVal;

	}

	//파트너사 회원가입
	@RequestMapping(value = "/signupForPartner.proc")
	public String signUpForPartnerProc(Model model, Users vo,  UsersDetail uvo, HttpServletRequest request) {
		System.out.println("----------파트너사 sign Up Proc----------");
		
		return "/login/signin";
	}	
	
}
