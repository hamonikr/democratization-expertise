package com.de.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.de.cmmn.service.CmmnService;
import com.de.login.service.GoogleUser;
import com.de.login.service.LoginService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginHistoryVO;
import com.de.login.vo.LoginVO;


@Controller
@RequestMapping(value = "/login")
public class LoginController {
	@Autowired
	LoginService service;
	
	@Autowired
	CmmnService cmmnService;
	
	@RequestMapping("")
	 public String login(HttpSession session, HttpServletRequest request) {
		System.out.println("----login page----");
		String referrer = request.getHeader("Referer");
		session.setAttribute("referrer", referrer);
	    return "/login/login";
	  } 

	@RequestMapping("/logout")
	 public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws Exception{ 		
		System.out.println("---logout----");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
			session.invalidate();
		}
		
		return "redirect:/";
	 } 
		
	
	@RequestMapping("/login")
	 public String loginSuccess(Model model, @AuthenticationPrincipal SecurityMember user, LoginHistoryVO hvo , LoginVO vo, HttpSession session ) throws Exception{
		System.out.println("<<--- controller for normal loginSuccess-->> ");
	
		if(user!=null) {
		System.out.println("user id --->" + user.getUserid());
		System.out.println("user pw --->" + user.getUserpassword());
		System.out.println("user no --- >" + user.getUserno());
		System.out.println("user no --- >" + user.getEnterprisename());
		System.out.println("representat >> " +vo.getRepresentat());

		}
		
		// 로그인 히스토리 저장
		hvo.setUserid(user.getUserid());
		int ret = service.saveLoginHistory(hvo);
		if(ret ==1) {
			System.out.println("save history");
		}else {
			System.out.println("fail");
		}
		
		// 유저가 회사계정이냐 일반 유저이냐에 따라 프로필 페이지 변경
		vo = service.getUserInfo(user.getUserid());
		System.out.println("대표 유저 여부==?? "+vo.getRepresentat());
		
		session.setAttribute("userSession", vo);
		model.addAttribute("loginUser", user);
		
		Integer val = null;
		String returnUrl = (String)session.getAttribute("referrer");
		
		System.out.println("returnUrl======>>>> " +returnUrl);
		session.removeAttribute("referrer");

		
		if(returnUrl==null || returnUrl.contains("/sendRecoveryEmail.proc") || returnUrl.contains("/login")) {			
			return "redirect:/questions/list";
		} else {
			return "redirect:"+returnUrl;
		}
	}
	
	@RequestMapping("/socialLogin")
	 public String socialLogin(Model model, HttpSession session , LoginHistoryVO hvo, LoginVO vo,HttpServletRequest request) throws Exception{
		System.out.println("<<--- controller for sns loginSuccess-->> ");
		
		String returnUrl = (String)session.getAttribute("referrer");
		session.removeAttribute("referrer");
		
		String goo = (String) session.getAttribute("googleId");
		session.removeAttribute("googleId");
		System.out.println("google============"+goo);
		vo = service.getSocialUserInfo(goo);
		
		// 로그인 히스토리 저장
		hvo.setUserid(goo);
		int ret = service.saveLoginHistory(hvo);
		if(ret ==1) {
			System.out.println("save history");
		}else {
			System.out.println("fail");
		}
		
		session.setAttribute("userSession", vo);
		System.out.println("userno======"+vo.getUserno());
		model.addAttribute("loginUser", session.getAttribute("userSession"));
		
		//return "redirect:/users/activity/"+vo.getUserno();
		if(returnUrl==null || returnUrl.contains("/sendRecoveryEmail.proc") || returnUrl.contains("/login")) {			
			return "redirect:/questions/list";
		} else {
			return "redirect:"+returnUrl;
		}
	} 

	 @RequestMapping("/message")
	 public String message( HttpServletRequest request ) throws Exception {
		 return "/cmmn/message";
		 
	 }
	 
	
	
}
