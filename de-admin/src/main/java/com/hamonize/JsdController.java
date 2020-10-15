package com.hamonize;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/jsd")
public class JsdController {

	@RequestMapping("/feedback")
	public String jsd() {
		System.out.println("jsd=======================");
		return "/jds/feedback";

	}

}
