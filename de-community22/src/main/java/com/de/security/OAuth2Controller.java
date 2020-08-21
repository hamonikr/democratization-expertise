package com.de.security;


import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.de.findAccount.service.FindAccountService;
import com.de.login.service.SecurityMember;
import com.de.signup.SignupService;
import com.de.user.Users;
import com.de.findAccount.service.PostMail;

@Controller
public class OAuth2Controller {

	@GetMapping({"", "/"}) 
	 public String getAuthorizationMessage() {
	//	System.out.println("cs-->" + cs.toString());
		System.out.println("----home page----");
	     return "/index";
	  }
	
	@GetMapping("/login")
	 public String login() {
		System.out.println("----login page----");
	    return "/users/login";
	  } 

//	@GetMapping("/logout")
//	 public String logout(HttpServletRequest request) { 		
//		System.out.println("---logout----");
//		
//		return "redirect:/users/login";
//	 } 
	
	@RequestMapping("/loginSuccess")
	 public String loginSuccess(Model model, HttpServletRequest request, 
			 @AuthenticationPrincipal SecurityMember user, HttpSession session) {
		System.out.println("<<--- controller loginSuccess-->> ");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
		  String username = ((UserDetails)principal).getUsername();
			System.out.println("111username--->" + username);

		} else {
		  String username = principal.toString();
			System.out.println("222username--->" + username);

		}
		
		
		return "/users/main"; 
	} 

	@GetMapping("/loginFailure") 
	public String loginFailure() { 
		System.out.println("---login fail---");
	    return "/users/loginFailure";
	 }

//	@GetMapping("/account-recovery")
//	 public String accountRecovery(HttpServletRequest request) { 		
//		System.out.println("---account-recovery----");
//		
//		return "/users/forgotPw";
//	 } 
	
//	@GetMapping("/sendRecoveryEmail")
//	 public int sendRecoveryEmail(HttpServletRequest request, Users vo) throws Exception { 		
//		System.out.println("---sendRecoveryEmail Proc----");
//		System.out.println("userEmail--> " + vo.getUserEmail());
//		
//		int up_result=0;
//		PostMail sendMail = new PostMail();
//
//		StringBuffer tmpRnd = new StringBuffer();
//		Random rnd = new Random();
//		
//		Users checkUser = service.isExistAccount(vo);
//		
//		
//		if(checkUser.getUsersDetail().getActiveAt()==0) {
//		    System.out.println("비밀번호 조회/변경 성공!");
//			for (int i = 0; i < 5; i++) {
//			    int rIndex = rnd.nextInt(3);
//			    switch (rIndex) {
//			    case 0:
//			        // a-z
//			    	tmpRnd.append((char) ((int) (rnd.nextInt(26)) + 97));
//			        break;
//			    case 1:
//			        // A-Z
//			    	tmpRnd.append((char) ((int) (rnd.nextInt(26)) + 65));
//			        break;
//			    case 2:
//			        // 0-9
//			    	tmpRnd.append((rnd.nextInt(10)));
//			        break;
//			    }
//			}
//			// 버퍼에있는 값 String으로 변경
//			String rndPw = tmpRnd.toString();		
//			vo.setUserPassword(rndPw);
//		
//			
//			System.out.println("비밀번호 초기화 성공 ===> "+vo.getUserPassword());
//			sendMail.inviteMail(vo);				
//			try {
//				up_result = service.resetUserPw(vo);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//	
//			return up_result;
//
//		} else {
//		    System.out.println("비밀번호 조회/변경 실패!");
//		    }
//				
//		return up_result;	
//		
//	}
}
