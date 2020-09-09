package com;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import com.de.cmmn.CmmnMap;
import com.de.login.service.SecurityMember;


@Configuration
public class AuthSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
       System.out.println("------onAuthenticationSuccess--------");

		HttpSession httpSession = request.getSession(true);
        CmmnMap param = new CmmnMap();        
        param.put("userid",request.getParameter("username")); 
       
        clearAuthenticationAttributes(request);
        
//      DefaultOAuth2User user = (DefaultOAuth2User) authentication.getPrincipal();
//    	 String name = (String) user.getAttributes().get("name");
//		 String email = (String) user.getAttributes().get("email");
//        
//      System.out.println("session user value-->" + user.toString());        
//		 System.out.println("DefaultOAuth2User-->"+ user.getAttributes().keySet());
//		 System.out.println("username-->"+ name);
//		 System.out.println("email-->"+ email);
	
		
        SecurityMember user = (SecurityMember) authentication.getPrincipal();
        
        if(user.getActiveat() == 0) {        	
	       httpSession.setAttribute("userSession", user);   
	      	 response.setStatus(HttpServletResponse.SC_OK);		 
	      	 System.out.println("로그인 성공 프로필페이지로");    	 
	      	 response.sendRedirect("/login/login");
      	 }else{
      		System.out.println("비활성화된 계정 로그인 시도");
         	request.setAttribute("url", "/");
      	 }
     
	}

	 protected void clearAuthenticationAttributes(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
