
package com.de.wiki;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.de.login.service.SecurityMember;

@Controller
@RequestMapping(value = "/wiki")
public class WikiController {
	@RequestMapping("/getStart")
	 public String accountRecovery(HttpServletRequest request, Wiki vo) { 		
		System.out.println("---wiki start---");
		
		return "/wiki/start";
	 }
	
	@RequestMapping("/createHelp")
	 public String createHelp(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model) { 		
		System.out.println("---wiki help create!---");
		if(user.getUserid()!=null) {
			
			System.out.println("현재로그인한 계정정보 ==>");
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());
		} else {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
		}
		return "/wiki/createHelp";
	 } 
	
	@RequestMapping("/createTag")
	 public String createTag(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model) { 		
		System.out.println("---wiki tag create!---");
		if(user.getUserid()!=null) {
			
			System.out.println("현재로그인한 계정정보 ==>");
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());
		} else {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
		}
		
		return "/wiki/createTag";
	 } 
}
