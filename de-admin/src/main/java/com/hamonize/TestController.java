package com.hamonize;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/test")
public class TestController {

	@RequestMapping("/layout")
	public String test() {

		return "test/index";

	}

}
