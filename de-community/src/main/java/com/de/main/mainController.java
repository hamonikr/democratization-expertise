package com.de.main;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class mainController {

	@GetMapping({ "", "/" })
	public String mainPage() {
		System.out.println("----home page----");
		return "redirect:/questions/list";
	}

}
