package com.de.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.de.login.service.SecurityMember;


@Controller
@RequestMapping(value = "/login")
public class LoginController {
	
	
	@RequestMapping("")
	 public String login() {
		System.out.println("----login page----");
	    return "/login/login";
	  } 

	@RequestMapping("/logout")
	 public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws Exception{ 		
		System.out.println("---logout----");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		
		return "redirect:/";
	 } 
	
	
	
	@RequestMapping("/login")
	 public String loginSuccess(Model model, @AuthenticationPrincipal SecurityMember user ) {
		System.out.println("<<--- controller for normal loginSuccess-->> ");
	
		System.out.println("user id --->" + user.getUserid());
		System.out.println("user pw --->" + user.getUserpassword());
		System.out.println("user no --- >" + user.getUserno());
		
		model.addAttribute("loginUser", user);
		
		
//		return "/users/profile";
		return "redirect:/users/activity/"+user.getUserno();
	} 

	 @RequestMapping("/message")
	 public String message( HttpServletRequest request ) throws Exception {
		 return "/cmmn/message";
		 
	 }
	 
	
	
}
