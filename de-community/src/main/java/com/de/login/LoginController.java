package com.de.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.GoogleUser;
import com.de.login.service.LoginService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginHistoryVO;
import com.de.login.vo.LoginVO;


@Controller
@RequestMapping(value = "/login")
public class LoginController {
	@Autowired
	LoginService service;
	
	@Autowired
	CmmnService cmmnService;
	
	@RequestMapping("")
	 public String login(HttpSession session, HttpServletRequest request) {
		System.out.println("----login page----");
		String referrer = request.getHeader("Referer");
		session.setAttribute("referrer", referrer);
	    return "/login/login";
	  } 

	@RequestMapping("/logout")
	 public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response)
				throws Exception{ 		
		System.out.println("---logout----");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
			session.invalidate();
		}
		
		return "redirect:/";
	 } 
		
	
	
	@RequestMapping("/login")
	 public String loginSuccess(Model model, @AuthenticationPrincipal SecurityMember user, LoginHistoryVO hvo , LoginVO vo, HttpSession session ) throws Exception{
		System.out.println("<<--- controller for normal loginSuccess-->> ");
	
		CmmnMap param = new CmmnMap();
		// 로그인 히스토리 저장
		hvo.setUserid(user.getUserid());
		int ret = service.saveLoginHistory(hvo);
		if(ret ==1) {
			System.out.println("save history");
			
			param.put("userid", user.getUserid());
			param.put("userno", user.getUserno());
			int tlCnt = cmmnService.selectCount("loginCheckToday", param);
			if(tlCnt == 1) {
				// 점수등록
				param.put("userno", user.getUserno());
				param.put("score", 3);
				cmmnService.updateObject("saveScore", param);
				//연속 로그인 체크
				int ylCnt = cmmnService.selectCount("loginCheck", param);
				param.put("lcnt", ylCnt);
				cmmnService.updateObject("updateLoginDays", param);
				cmmnService.updateObject("updateMaxLoginDay", param);
			}
		}else {
			System.out.println("fail");
		}
		
		// 유저가 회사계정이냐 일반 유저이냐에 따라 프로필 페이지 변경
		vo = service.getUserInfo(user.getUserid());
		System.out.println("대표 유저 여부==?? "+vo.getRepresentat());
		System.out.println("회사이름 ==?? "+vo.getEnterprisename());

		session.setAttribute("userSession", vo);
		model.addAttribute("loginUser", user);
		
		String returnUrl = (String)session.getAttribute("referrer");
		
		System.out.println("returnUrl======>>>> " +returnUrl);
		session.removeAttribute("referrer");

		
		if(returnUrl==null || returnUrl.contains("/sendRecoveryEmail.proc") || returnUrl.contains("/login")) {			
			return "redirect:/questions/list";
		} else {
			return "redirect:"+returnUrl;
		}
	}
	
	
	@RequestMapping("/socialLogin/{webAppGubun}")
	 public String socialLogin(Model model, HttpSession session , LoginHistoryVO hvo, LoginVO vo,HttpServletRequest request,
			 @PathVariable("webAppGubun") String webAppGubun, RedirectAttributes redirectAttributes ) throws Exception{
		
		
		System.out.println("<<--- controller for sns loginSuccess-->> ");
		
		
		CmmnMap param = new CmmnMap();
		String returnUrl = (String)session.getAttribute("referrer");
		session.removeAttribute("referrer");
		
		String goo = (String) session.getAttribute("googleId");
		String gooNm = (String) session.getAttribute("googleNm");
		String gooPicture = (String) session.getAttribute("googlePicture");
		System.out.println("goo=========="+ goo);
		
		session.removeAttribute("googleId");
		
		vo = service.getSocialUserInfo(goo);
		
		
		// 로그인 히스토리 저장
		hvo.setUserid(goo);
		int ret = service.saveLoginHistory(hvo);
		if(ret ==1) {
			System.out.println("save history");
			// 점수등록
			param.put("userid", vo.getUserid());
			param.put("userno", vo.getUserno());
			int tlCnt = cmmnService.selectCount("loginCheckToday", param);
			if(tlCnt == 1) {
				param.put("userno", vo.getUserno());
				param.put("score", 3);
				cmmnService.updateObject("saveScore", param);
			//연속 로그인 체크
				int ylCnt = cmmnService.selectCount("loginCheck", param);
				param.put("lcnt", ylCnt);
				cmmnService.updateObject("updateLoginDays", param);
				cmmnService.updateObject("updateMaxLoginDay", param);
			}
		}else {
			System.out.println("fail");
		}
		
		session.setAttribute("userSession", vo);
		System.out.println("userno======"+vo.getUserno());
		model.addAttribute("loginUser", session.getAttribute("userSession"));
		
		if(webAppGubun.equals("web")) {
			//return "redirect:/users/activity/"+vo.getUserno();
			if(returnUrl==null || returnUrl.contains("/sendRecoveryEmail.proc") || returnUrl.contains("/login")) {			
				return "redirect:/questions/list";
			} else {
				return "redirect:"+returnUrl;
			}
		}else {

			LoginVO svo = service.getUserInfo(vo.getUserid());
			
			System.out.println("svo=="+ svo);
		    redirectAttributes.addFlashAttribute("vo", svo);
		    

//			model.addAttribute("vo", svo);
			
			return "redirect:/login/restSocial";
			
			
			
			
		}
	} 

	 @RequestMapping("/message")
	 public String message( HttpServletRequest request ) throws Exception {
		 return "/cmmn/message";
		 
	 }


	@RequestMapping("/form/{gubun}")
	 public String form(HttpSession session, HttpServletRequest request, @PathVariable("gubun") String gubun) {
		System.out.println("a=========++++"+ gubun);
		String referrer = request.getHeader("Referer");
		session.setAttribute("webAppGubun", gubun);
		System.out.println("----login form page-11---" + referrer);
		System.out.println("----login form page-22---" + session.getAttribute("webAppGubun") );
		
		
	    return "/login/form";
	  } 
		

	 @RequestMapping("/restSocial")
	 public String restSocial( Model model, HttpServletRequest request , LoginVO dataMap   ) throws Exception {
		 System.out.println("========aaaaaaaaaaaaaaaaa============c========="+dataMap);
		 model.addAttribute("socialDataMap", dataMap);
		 return "/login/restSocial";
		 
	 }

	 @RequestMapping("/socialDataPage")
	 public String socialDataPage( Model model, HttpServletRequest request , LoginVO vo ) throws Exception {
		 System.out.println("========aaaaaaaaaaaaaaaaa=============b=========="+vo);
		 model.addAttribute("socialDataMap", vo);
		 return "/login/socialDataPage";
		 
	 }
	 
	
}
