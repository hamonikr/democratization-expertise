package com.de.login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner.Mode;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.de.signup.SignupRepository;
import com.de.signup.SignupService;
import com.de.user.Users;
import com.de.user.UsersDetail;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.de.login.service.LoginRepository;
import com.de.login.service.SecurityMember;

@Controller
@RequestMapping(value = "/login")
public class LoginController {
    @Autowired
    SignupService service;
    
    SignupRepository sr;
    
    @Autowired
    LoginRepository lr;
    
	@RequestMapping(value = "/login")
	public String loginView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------show log In page----------");

		return "/login/signin";
	}
	
	@RequestMapping(value = "/googleCallback")
	public String googleCallback(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------show log In page----------");

		return "/login/googleCallback";
	}
	
	@RequestMapping(value = "/signin")
	public String loginProc(HttpSession session, HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Model model, Users vo, @PageableDefault Pageable pageable) {
		System.out.println("----------log In proc----------");

	return "/sample/list";
	}
	
	@RequestMapping(value = "/snsLogin")
	public String snsProc(HttpSession session, HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Model model, Users vo, @PageableDefault Pageable pageable) {
		System.out.println("----------sns log In proc----------");
	//	System.out.println(session.getAttribute("UserSession"));
	System.out.println("user userId--->"+user.getUserId());
	System.out.println("user userPassword--->"+user.getUserPassword());
	model.addAttribute("msg", user.getUserId());

	return "/sample/list";
	}
	
	
	
	@RequestMapping(value = "/checkDuplication/{userId}")
	@ResponseBody
	public String checkDuplication(@PathVariable("userId") String userId, HttpSession session, HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Model model, Users vo, @PageableDefault Pageable pageable) {
	String idChk = null;
	System.out.println("아이디 중복체크---> "+userId);
	
	if(lr.existsByUserId(userId)==true) {
		idChk="true";
	}else {
		idChk="false";
	}
	
	System.out.println(idChk);		
			
		return idChk;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response,@AuthenticationPrincipal SecurityMember user) throws Exception {
		System.out.println("----------log out----------");
			
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		System.out.println("log out controller auth==>"+auth.toString());

		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}	
	
		return "redirect:/login/login";
	}

	
	@RequestMapping("/message")
	public String message(HttpServletRequest request, ModelMap model, RedirectAttributes rttr) throws Exception {
		System.out.println("mm msg--> "+request.getAttribute("message"));
		String msg = (String) request.getAttribute("message");
		msg = "PW";
		System.out.println("msg--> "+msg);
		rttr.addFlashAttribute("msg",msg);
		 return "redirect:/login/login";
		 
	}

	@RequestMapping(value = "/signup")
	public String signUpView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------sign Up msg----------");
		return "/login/signup";
	}

	// naver 소셜 로그인 및 가입
	@RequestMapping(value = "/naverCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, HttpSession session, Users vo)throws IOException {
		System.out.println("====> naver callback controller<=====");
		
//		Login result = lr.findByUserEmailAndUserId(email,id);

			return "/login/naverCallback";
			
		
	}
	
	@RequestMapping(value = "/personalInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public String personalInfo( RedirectAttributes rttr, Model model, HttpSession session, Users vo, UsersDetail uvo, @RequestParam String access_token)throws IOException {
		System.out.println("====> naver personal info controller<=====");
		System.out.println("user id--> " + vo.getUserId());
		System.out.println("user email--> " + vo.getUserEmail());
		System.out.println("user name--> " + vo.getUserName());
		System.out.println("access_token ---->"+ access_token);
		
		String userPassword = "@fromnaver";
		//ModelAndView view = new ModelAndView();
		//DB에 유저정보 저장 
		//소설가입 = 2
		vo.setUserStatus(2);
		vo.setUserPassword(userPassword);
		System.out.println("vo-->" + vo.toString());
		
		//최초 로그인 여부
		System.out.println("userEmail-->" + vo.getUserEmail());
		String email = vo.getUserEmail();
		String id = vo.getUserId();
		
		Login result = lr.findByUserEmailAndUserId(email,id);
		System.out.println("아이디 존재 여부----> "+result.toString());
		
		
		if(result.getUserNo() == null ) { //해당 이메일을 사용하는 계정이 존재하지 않는 경우만 저장			
			try {
				 service.save(vo);
				 if(vo.getUserId() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserNo(vo.getUserNo());
					 service.save(uvo);
					 System.out.println("=====user details info save====");
					 rttr.addFlashAttribute("procVal", 'Y');
					 	
				 }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("저장 실패!");
				e.printStackTrace();
				rttr.addFlashAttribute("procVal",'F');
				
			}
		}else { // 가입된 계정인 경우

			System.out.println("해당 이메일로된 계정이 이미 존재함");
			rttr.addFlashAttribute("procVal",'E');

		}		
		 return "redirect:/login/naverCallback";
	}
	
}
