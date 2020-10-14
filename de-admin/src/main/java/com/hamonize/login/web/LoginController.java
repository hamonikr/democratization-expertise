package com.hamonize.login.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.login.service.LoginService;
import com.hamonize.login.service.SecurityMember;
import com.hamonize.user.service.UserVO;


@Controller
@RequestMapping("/sign")
public class LoginController {

	@Autowired
	private LoginService lService;

	@Autowired
	private CmmnService cmmnService;
	

	@RequestMapping("/login")
	public String login(HttpServletRequest request, ModelMap model) throws Exception {
//		System.out.println(request.getParameter("result"));
//		if(request.getParameter("result") != null) {
//			if(request.getParameter("result").equals("R")) {
//				model.addAttribute("message", messageSource.getMessage("common.login.fail", null, Locale.getDefault()));
//				model.addAttribute("url", "/sign/login");
//				return "cmmn/message";
//			}else if(request.getParameter("result").equals("P")) {
//				model.addAttribute("message", messageSource.getMessage("error.BadCredentials", null, Locale.getDefault()));
//				model.addAttribute("url", "/sign/login");
//				return "cmmn/message";
//			}else if(request.getParameter("result").equals("E")) {
//				model.addAttribute("message", messageSource.getMessage("error.InternalAuthenticationServiceException", null, Locale.getDefault()));
//				model.addAttribute("url", "/sign/login");
//				return "cmmn/message";
//			}
//			
//		}     
	    
	    return "/login/login"; 
	}
	
	@RequestMapping("/message")
	public String message(HttpServletRequest request, ModelMap model) throws Exception {
		return "cmmn/message";	
	}


	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/sign/login";
	}

//	@RequestMapping("loginProc")
//	public String loginProc(HttpServletRequest request, UserVO vo, ModelMap model) throws Exception{
//		//lService.getUser(vo);
//		return "/views/login/login";		
//	}


	@RequestMapping("/signup")
	public String signup(HttpServletRequest request, ModelMap model) throws Exception {
		CmmnMap param = new CmmnMap();
		param.put("code_id", "user_auth_role");
		model.addAttribute("codeList", cmmnService.selectList("getCode", param));
		return "/login/signup";
	}


	@RequestMapping("/signupProc")
	public String signupProc(HttpServletRequest request, UserVO vo) throws Exception {
		lService.signUp(vo);
		return "/login/login";
	}

}
