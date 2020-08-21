package com.de.findAccount;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.de.findAccount.service.FindAccountService;


@Controller
@RequestMapping(value = "/accountRecovery")
public class FindAccountController {
	@Autowired
	FindAccountService service;
	
	@RequestMapping("/account-recovery")
	 public String accountRecovery(HttpServletRequest request) { 		
		System.out.println("---account-recovery----");
		
		return "/users/forgotPw";
	 } 
	
	@RequestMapping("/sendRecoveryEmail")
	 public String sendRecoveryEmail(HttpServletRequest request, Account vo) { 		
		System.out.println("---sendRecoveryEmail Proc----");
		int up_result;
		
		try {
			vo = service.isExistAccount(vo);		
			up_result = service.resetUserPw(vo);
			
			if(up_result==1) {
				System.out.println("비밀번호 초기화 및 이메일 발송 성공!");
				} else {					
				System.out.println("비밀번호 초기화 및 이메일 발송 실패!");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/main";
						
	}
}
