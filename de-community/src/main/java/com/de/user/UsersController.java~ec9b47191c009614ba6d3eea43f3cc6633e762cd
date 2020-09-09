package com.de.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/users")
public class UsersController {

	@RequestMapping("/list")
	 public String list() {
		System.out.println("----users list page----");
	    return "/users/profile";
	  } 
	
	@RequestMapping("/activity")
	 public String c() {
		System.out.println("----users profile page----");
	    return "/users/activity";
	  } 
	
	@RequestMapping("/profile")
	 public String profile() {
		System.out.println("----users profile page----");
	    return "/users/profile";
	  } 
}
