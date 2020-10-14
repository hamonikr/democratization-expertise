package com.hamonize;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController22 {

	@RequestMapping("/a")
	public String index() {
		return "/";

	}

}
