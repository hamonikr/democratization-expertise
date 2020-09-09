package com.de;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value = "/de")
public class deController {

//	===================

	@RequestMapping("/stackedlist")
	public String stackedlist() {
		return "/de/stactedlist";
	}


	@RequestMapping("/stactedview")
	public String stactedview() {
		return "/de/stactedview";
	}


	@RequestMapping("/stactedins")
	public String stactedins() {
		return "/de/stactedins";
	}


	@RequestMapping("/tagslist")
	public String tagslist() {
		return "/de/tagslist";
	}


	@RequestMapping("/userlist")
	public String userlist() {
		return "/de/userlist";
	}


	@RequestMapping("/userview")
	public String userview() {
		return "/de/userview";
	}


	@RequestMapping("/userins")
	public String userins() {
		return "/de/userins";
	}


	@RequestMapping("/newsletter")
	public String newsletter() {
		return "/de/newsletter";
	}


	@RequestMapping("/wiki")
	public String wikimain() {
		return "/de/wikimain";
	}

}
