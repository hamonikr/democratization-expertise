package com.de.findAccount;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.de.findAccount.service.FindAccountService;


@Controller
@RequestMapping(value = "/accountRecovery")
public class FindAccountController {
	@Autowired
	FindAccountService service;
	
	@Autowired
	private MessageSource messageSource;

	
	@RequestMapping("/sendRecoveryEmail")
	 public String accountRecovery(HttpServletRequest request) { 		
		System.out.println("---account-recovery----");
		
		return "/login/forgotPw";
	 } 
	
	@RequestMapping("/sendRecoveryEmail.proc")
	 public String sendRecoveryEmail(HttpServletRequest request, HttpServletResponse response, Account vo) throws Exception { 		
		System.out.println("---sendRecoveryEmail Proc----");
		int up_result=0;
		
			vo = service.isExistAccount(vo);		
		if(vo != null) {
			System.out.println("aaaaa");
			up_result = service.resetUserPw(vo);
			
			if(up_result==1) {
				System.out.println("비밀번호 초기화 및 이메일 발송 성공!");
				request.setAttribute("message", messageSource.getMessage("email.send.success", null, Locale.getDefault()));
		    	request.getRequestDispatcher("/accountRecovery/message").forward(request, response);
				
		    	System.out.println("성공!");

			} else {					
				System.out.println("비밀번호 초기화 및 이메일 발송 실패!");
				
				request.setAttribute("message", messageSource.getMessage("login.incorrect.id", null, Locale.getDefault()));
		    	request.getRequestDispatcher("/accountRecovery/message").forward(request, response);

			}
		} else {
			System.out.println("bbbbb");
			request.setAttribute("message", messageSource.getMessage("login.incorrect.email", null, Locale.getDefault()));
	    	request.getRequestDispatcher("/accountRecovery/message").forward(request, response);

		}	
		System.out.println("cccccc");
   // 	response.sendRedirect("/login/login");

		return "redirect:/login";
	}

	@RequestMapping("/message")
	 public String message( HttpServletRequest request ) throws Exception {
		 return "/cmmn/message";
		 
	 }
}
