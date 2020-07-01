package com.de.login;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/login")
public class LoginController {


	@RequestMapping(value = "/login")
	public String getList(Model model, @PageableDefault Pageable pageable) {
		System.out.println("----------sample----------");
	
		return "/login/signin";
	}

}
