package com.de.login;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@RequestMapping(value = "/login")
	public String loginView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------log In----------");
	
		return "/login/signin";
	}
	
	@RequestMapping(value = "/signin")
	public void loginProc(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------log In proc----------");
	
		//return "/login/signin";
	}

	@RequestMapping(value = "/signup")
	public String signUpView(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------sign Up----------");
	
		return "/login/signup";
	}
	
	
}
