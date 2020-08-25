package com.de.security;


import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
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
		System.out.println("----home page----");
	     return "/users/index";
	  }
	
	@GetMapping("/login")
	 public String login() {
		System.out.println("----login page----");
	    return "/users/login";
	  } 

	@GetMapping("/logout")
	 public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws Exception{ 		
		System.out.println("---logout----");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/users/login";
	 } 
	
	
	
	@RequestMapping("/loginSuccess")
	 public String loginSuccess(Model model, HttpServletRequest request, 
			 @AuthenticationPrincipal UserEntity user, HttpSession session) {
		System.out.println("<<--- controller for normal loginSuccess-->> ");

		System.out.println("session--> user name..?"+session.getAttribute("UserSession").toString());
		
		return "/users/profile"; 
	} 
	
	
	@RequestMapping("/snsLoginSuccess")
	 public String snsLoginSuccess(Model model, HttpServletRequest request, 
			 @AuthenticationPrincipal DefaultOAuth2User user, HttpSession session) {
		System.out.println("<<--- controller for sns loginSuccess-->> ");

		System.out.println("DefaultOAuth2User-->"+ user.getAttributes().keySet());
		System.out.println("username-->"+ (String) user.getAttributes().get("name"));
		System.out.println("email-->"+ (String) user.getAttributes().get("email"));
	
		
		System.out.println("session--> user name..?"+session.getAttribute("UserSession").toString());
		
		return "/users/profile"; 
	} 

	@GetMapping("/loginFailure") 
	public String loginFailure() { 
		System.out.println("---login fail---");
	    return "/users/loginFailure";
	 }


}
