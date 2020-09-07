package com.de.wiki;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/wiki")
public class WikiController {
	@RequestMapping("/getStart")
	 public String accountRecovery(HttpServletRequest request) { 		
		System.out.println("---wiki start---");
		
		
		
		return "/wiki/start";
	 }
	
	@RequestMapping("/create")
	 public String create(HttpServletRequest request) { 		
		System.out.println("---wiki create!---");
		
		return "/wiki/create";
	 } 
}
