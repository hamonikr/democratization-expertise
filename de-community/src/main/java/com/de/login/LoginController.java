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
import com.de.login.service.SecurityMember;

@Controller
@RequestMapping(value = "/login")
public class LoginController {
    @Autowired
    SignupService service;
    
    SignupRepository sr;
    
	@RequestMapping(value = "/login")
	public String loginView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------show log In page----------");

		return "/login/signin";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("----------log out----------");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/login/login";
	}

	@RequestMapping(value = "/signin")
	public void loginProc(HttpSession session, @AuthenticationPrincipal SecurityMember user, Model model, Users vo, @PageableDefault Pageable pageable) {
		System.out.println("----------log In proc----------");
	//	System.out.println(session.getAttribute("UserSession"));
	System.out.println(session.getId());
	System.out.println(user.getUserId());
	System.out.println(user.getUserPassword());
		
		//return "/sample/list";
	}

	@RequestMapping(value = "/signup")
	public String signUpView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------sign Up page----------");
		
		return "/login/signup";
	}

	// naver 소셜 로그인 및 가입
	@RequestMapping(value = "/naverCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, HttpSession session, Users vo)throws IOException {
		System.out.println("=====================================");
		System.out.println("====> naver callback controller<=====");
		
		System.out.println("userEmail-->" + vo.getUserEmail());
		String email = vo.getUserEmail();
		System.out.println("아이디 존재 여부----> "+service.isExist(email));
	if(service.isExist(email)==true) {//기존에 등록된 계정
		model.addAttribute("retVal", "E");
		return "/sample/list";
	}else {// 새롭게 가입하는 sns 연동계정
			return "/login/naverCallback";

	}
		
	//	return "/login/naverCallback";

	}
	
	@RequestMapping(value = "/personalInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public void personalInfo( RedirectAttributes redirect ,Model model, HttpSession session, Users vo, UsersDetail uvo, @RequestParam String access_token)throws IOException {
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
		System.out.println("아이디 존재 여부----> "+service.isExist(email));
		
		
		if(service.isExist(email) != true ) { //해당 이메일을 사용하는 계정이 존재하지 않는 경우만 저장			
			try {
				 service.save(vo);
				 if(vo.getUserId() != null) {
					 System.out.println("=====user info save====");
					 uvo.setUserNo(vo.getUserNo());
					 service.save(uvo);
					 System.out.println("=====user details info save====");
					redirect.addFlashAttribute("procVal", 'Y');
	
				 }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("저장 실패!");
				e.printStackTrace();
				redirect.addFlashAttribute("procVal",'F');
				
			}
		}else { // 가입된 계정인 경우

			System.out.println("해당 이메일로된 계정이 이미 존재함");
//			model.addAttribute("retVal","해당 이메일로된 계정이 이미 존재함" );	
//			System.out.println("해당 이메일로된 계정이 이미 존재함1"+model);
//			redirect.addFlashAttribute("procVal", "E");
		//	model.addAttribute("retVal", "E");
		}		
		
		//return "redirect:naverCallback";
		//return "redirect:login/login";
		//return "/login/naverCallback";

	}
	
}
