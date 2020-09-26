
package com.de.cmmn;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.de.login.service.SecurityMember;
import com.de.question.QuestionsService;
import com.de.wiki.Wiki;
import com.de.wiki.service.WikiService;

@Controller
@RequestMapping(value = "/cmmn")
public class CmmnController {
	
	@Autowired
	WikiService service;
	
	@Autowired
	QuestionsService qs;
	
	@RequestMapping("/view")
	@ResponseBody
	 public Wiki view(HttpServletRequest request, Model model) throws Exception { 			
		
		Wiki wiki_view = service.getView(19);
		//model.addAttribute("result", wiki_view);	
		System.out.println(wiki_view);
		return wiki_view;
	 }

}
