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
	     return "/home";
	  }
	
	@GetMapping("/login")
	 public String login() {
		System.out.println("----login page----");
	    return "/login";
	  } 

	@GetMapping("/logout")
	 public String logout(HttpServletRequest request) { 
		System.out.println("---logout----");
		return "redirect:/login";
	 } 
	
	@RequestMapping("/loginSuccess")
	 public String loginSuccess(Model model, HttpServletRequest request, 
			 @AuthenticationPrincipal SecurityMember user, HttpSession session) {
		System.out.println("<<--- controller loginSuccess-->> ");
	
		System.out.println("id--->"+request.getAttribute("userId"));
//		System.out.println("id -> "+user.getUserId());
//		System.out.println("pw -> "+user.getUserPassword());
		return "/main"; 
	} 

	@GetMapping("/loginFailure") 
	public String loginFailure() { 
		System.out.println("---login fail---");
	    return "/loginFailure";
	 }

}
