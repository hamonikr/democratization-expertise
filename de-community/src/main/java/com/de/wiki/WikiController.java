
package com.de.wiki;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.de.login.service.SecurityMember;
import com.de.wiki.service.WikiService;

@Controller
@RequestMapping(value = "/wiki")
public class WikiController {
	
	@Autowired
	WikiService service;
	
		
	
	@RequestMapping("/getStart")
	 public String accountRecovery(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo,Model model) throws Exception { 		
		System.out.println("---wiki start---");		
		if(user!=null) {
			System.out.println("user type -->" +user.getRole());
		}
		
		// fna list
		List<Wiki> fna_list = service.getWikiHelp();
		model.addAttribute("result", fna_list);
	
		return "/wiki/start";
	 }
	

	@RequestMapping("/Help")
	 public String helplist(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo,Model model) throws Exception { 		
		System.out.println("---wiki view---");		
		vo.setSection("h");
		// fna list
		List<Wiki> fna_list = service.getWikiHelp();
		model.addAttribute("result", fna_list);
		for(int i =0;i<fna_list.size();i++){
			System.out.println(fna_list.get(i).getTitle());
		}
		// etc list
		
		
		return "/wiki/HelpList";
	 }
	
	
	@RequestMapping("/view/{wikino}")
	 public String view(HttpServletRequest request, @PathVariable("wikino") int wikino, @AuthenticationPrincipal SecurityMember user, Model model) throws Exception { 		
		System.out.println("---wiki view---");		
		if(user!=null) {
			System.out.println("user id -->" +user.getUserid());
			System.out.println("user role -->" +user.getRole());
			System.out.println("wikino --->"  +wikino);
		}
		
		Wiki wiki_view = service.getView(wikino);
		model.addAttribute("result", wiki_view);	
	//	System.out.println(wiki_view.getTitle());
		
	
		List<WikiHistory> history = service.getHistory(wikino);
		model.addAttribute("history", history);
		
		return "/wiki/view";
	 }

	
	@RequestMapping("/edit/{seq}")
	 public String historyView(HttpServletRequest request, @PathVariable("seq") int seq, Model model) throws Exception { 		
		System.out.println("---wiki view---");		
		
//		Wiki wiki_history_view = service.getView(wikino);
		WikiHistory wiki_history_view = service.getHistoryView(seq);
		model.addAttribute("history_view", wiki_history_view);	
		System.out.println(wiki_history_view.getTitle());
		
	
		
		return "/wiki/view";
	 }
	
	

	@RequestMapping("/edit.proc")
	 public String edit(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model) throws Exception { 		
		System.out.println("---wiki edit proc---");
		System.out.println("넘어온 값?" + vo.toString());
		if(user!=null) {
			vo.setUserno(user.getUserno());
			service.updateWiki(vo);
			
		} else {
			return "redirect:/login";
		}
		
		return "redirect:/wiki/Help";
	 }

	
	@RequestMapping("/saveHelp")
	 public String createHelp(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model)throws Exception { 		
		System.out.println("---wiki help create!---");
		
		if(user==null) {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";
			
		} else {		
			System.out.println("== 현재로그인한 계정정보 ==");
			System.out.println("section ==>" +vo.getSection());
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());		
			
			
			return "/wiki/createHelp";
		}
	 } 
	
	@RequestMapping("/saveTag")
	 public String createTag(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model)throws Exception  { 		
		System.out.println("---wiki tag create!---");		
		
		if(user==null) {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";
			
		} else {
			System.out.println("== 현재로그인한 계정정보 ==");
			System.out.println("section ==>" +vo.getSection());
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());
			
			return "/wiki/createTag";
		}
		
	 }
	
	

	@RequestMapping("/save.proc")
	 public String save(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model) throws Exception { 		
		System.out.println("---wiki help create proc---");
		int ret=0;
		
		vo.setUserno(user.getUserno());
		System.out.println("section==?" + vo.getSection());
		
		ret=service.save(vo);			
		
		if(ret==0) {
			System.out.println("도움말 문서 저장 실패");
		} else {			
			service.saveHistory(vo);
			System.out.println("도움말 문서 정상적으로 저장");			
		
		}
	
		return "redirect:/wiki/Help";

	} 

	
	@RequestMapping("/delete.proc")
	 public String delete(HttpServletRequest request, @AuthenticationPrincipal SecurityMember user, Wiki vo, Model model) throws Exception { 		
		System.out.println("---wiki delete proc---");
		System.out.println("---삭제할 wikino---" + vo.getWikino());
		int ret=0; 
		vo.setUserno(user.getUserno());
		ret= service.deleteWiki(vo.getWikino());

		
		if(ret==0) {
			System.out.println("위키 문서 삭제 실패");
		} else {			
			service.saveHistory(vo);
			System.out.println("위키 문서 정상적으로 삭제");			
		
		}
	
		return "redirect:/wiki/Help";

	} 

}
