
package com.de.wiki;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.question.QuestionsService;
import com.de.wiki.service.WikiService;

@Controller
@RequestMapping(value = "/wiki")
public class WikiController {
	
	@Autowired
	WikiService service;
	
	@Autowired
	QuestionsService qs;

	
	@RequestMapping("/getStart")
	 public String accountRecovery(HttpServletRequest request, LoginVO user, Wiki vo,Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki start---");		
		user = (LoginVO) httpSession.getAttribute("userSession");
		if(user!=null) {
			System.out.println("user type -->" +user.getRole());
		}
		
		// fna list
		List<Wiki> fna_list = service.getWikiList("h");
		model.addAttribute("result", fna_list);
		

		// MENUAL list
		List<Wiki> menual_list = service.getWikiList("m");
		model.addAttribute("menual_result", menual_list);
		
		// tag list
//		List<Wiki> tags_list = service.getWikiList("t");
//		model.addAttribute("tags", tags_list);

		
		List<Wiki> get_list = service.getWikiList("t");
		//List <Integer> tagno_cnt= new ArrayList<>();
		int [] tagno_cnt = new int[get_list.size()];
		for(int i=0;i<get_list.size();i++) {
			System.out.println(get_list.get(i).getWikino()+" : "+get_list.get(i).getTitle()+"\n : "+ get_list.get(i).getContents());			
			tagno_cnt[i] = service.getWikiCount(get_list.get(i).getWikino());
			System.out.println(get_list.get(i).getWikino()+" 번 태그가 포함된 질문 갯수-->" +tagno_cnt[i]);
			System.out.println("-------------------------------------------------------------");
			get_list.get(i).setRelatedcnt(tagno_cnt[i]);
		}
		
		
		model.addAttribute("tagsResult", get_list);
		
		return "/wiki/start";
	 }
	

	@RequestMapping("/Help/{gubun}")
	 public String helplist(HttpServletRequest request, LoginVO user, Wiki vo,Model model,@PathVariable("gubun") String gubun , HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki view---");		
		user = (LoginVO) httpSession.getAttribute("userSession");
		vo.setSection("h");
		// fna list
		List<Wiki> fna_list = service.getWikiList(gubun);
		model.addAttribute("result", fna_list);
		model.addAttribute("gubun", gubun);
		
		
		
		// etc list
		
		
		return "/wiki/HelpList";
	 }
	
	
	@RequestMapping("/view/{wikino}")
	 public String view(HttpServletRequest request, @PathVariable("wikino") int wikino, LoginVO user, Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki view---");	
		user = (LoginVO) httpSession.getAttribute("userSession");
		if(user!=null) {
			System.out.println("user id -->" +user.getUserid());
			System.out.println("user role -->" +user.getRole());
			System.out.println("wikino --->"  +wikino);
		}
		
		Wiki wiki_view = service.getView(wikino);
		System.out.println("section---?"+wiki_view.getSection());
		model.addAttribute("result", wiki_view);		
	
		List<WikiHistory> history = service.getHistory(wikino);
		model.addAttribute("history", history);
		
		return "/wiki/view";
	 }

	
	@RequestMapping("/edit/{seq}")
	 public String historyView(HttpServletRequest request, @PathVariable("seq") int seq,LoginVO user, Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki view---");		
		user = (LoginVO) httpSession.getAttribute("userSession");
		WikiHistory wiki_history_view = service.getHistoryView(seq);

		System.out.println("wiki_history_view wikino--> " + wiki_history_view.getWikino());
		model.addAttribute("history_view", wiki_history_view);	
		System.out.println(wiki_history_view.getTitle());
		
	
		
		return "/wiki/view";
	 }
	

	@RequestMapping("/saveHelp/{gubun}")
	 public String createHelp(HttpServletRequest request, LoginVO user, Wiki vo, Model model,@PathVariable("gubun") String gubun , HttpSession httpSession)throws Exception { 		
		System.out.println("---wiki help create!---");
		user = (LoginVO) httpSession.getAttribute("userSession");
		if(user==null) {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";
			
		} else {		
			System.out.println("== 현재로그인한 계정정보 ==");
			System.out.println("section ==>" +vo.getSection());
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());		
			
			model.addAttribute("gubun", gubun);	
			return "/wiki/createHelp";
		}
	 } 
	
	@RequestMapping("/saveTag")
	 public String createTag(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession)throws Exception  { 		
		System.out.println("---wiki tag create!---");		
		user = (LoginVO) httpSession.getAttribute("userSession");
		if(user==null) {
			System.out.println("wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";
			
		} else {
			System.out.println("== 현재로그인한 계정정보 ==");
			System.out.println("section ==>" +vo.getSection());
			System.out.println("user id ==>" + user.getUserid());
			System.out.println("userno ==>"+ user.getUserno());
	
			List<Wiki> tagList = qs.findAllTag();
			model.addAttribute("tagList", tagList);

			return "/wiki/createTag";
		}
		
	 }
	
	

	@RequestMapping("/save.proc")
	 public String save(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki create proc---");
		user = (LoginVO) httpSession.getAttribute("userSession");
		vo.setUserno(user.getUserno());
		System.out.println("section==?" + vo.getSection());
		
		String retunUrl = "";
		String gubun = request.getParameter("gubun");
		
		if(vo.getSection().equals("h")) {
			retunUrl = "/wiki/Help/h";
		}else if(vo.getSection().equals("m")) {
			retunUrl = "/wiki/Help/m";
		}else {
			retunUrl ="/wiki/getStart";
		}
		//wiki 문서 생성	
		//service.save(vo);	
		service.saveHistory(vo);
		return "redirect:" + retunUrl;
//		return "redirect:/wiki/getStart";

	} 

	@RequestMapping("/edit.proc")
	 public String edit(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki edit proc---");
		user = (LoginVO) httpSession.getAttribute("userSession");
		System.out.println("수정할 wikino?-->"+ vo.getWikino());
		if(user!=null) {
			vo.setUserno(user.getUserno());
			service.updateWiki(vo);
			
		} else {
			return "redirect:/login";
		}
		
		return "redirect:/wiki/getStart";
	 }

	
	@RequestMapping("/delete.proc")
	 public String delete(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession) throws Exception { 		
		System.out.println("---wiki delete proc---");
		System.out.println("---삭제할 wikino---" + vo.getWikino());
		user = (LoginVO) httpSession.getAttribute("userSession");
		int ret=0; 
		vo.setUserno(user.getUserno());
		ret= service.deleteWiki(vo.getWikino());

		
		if(ret==0) {
			System.out.println("위키 문서 삭제 실패");
		} else {			
			service.saveHistory(vo);
			System.out.println("위키 문서 정상적으로 삭제");			
		
		}
	
		return "redirect:/wiki/getStart";

	} 

}
