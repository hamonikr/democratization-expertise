package com.de.tag;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value = "/tags")
public class TagsController {

//	===================

	@RequestMapping("/list")
	public String tagslist() {
		return "/tags/list";
	}

}
