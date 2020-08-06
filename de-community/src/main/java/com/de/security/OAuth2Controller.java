package com.de.security;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.de.login.service.SecurityMember;

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

	@GetMapping("/account-recovery")
	 public String accountRecovery(HttpServletRequest request) { 		
		System.out.println("---account-recovery----");
		
		return "/users/forgotPw";
	 } 
	
}
