package com;


import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;
import com.de.security.UserEntity;
import com.de.security.service.CustomOAuth2UserService;


@Configuration
public class AuthSuccessHandler implements AuthenticationSuccessHandler {
	
	CustomOAuth2UserService cs;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
       System.out.println("------onAuthenticationSuccess--------");

		HttpSession httpSession = request.getSession(true);
        CmmnMap param = new CmmnMap();
        
        param.put("username",request.getParameter("username")); 
        clearAuthenticationAttributes(request);
        
        DefaultOAuth2User user = (DefaultOAuth2User) authentication.getPrincipal();

        
    	String name = (String) user.getAttributes().get("name");
		String email = (String) user.getAttributes().get("email");
        
       System.out.println("session user value-->" + user.toString());        
		System.out.println("DefaultOAuth2User-->"+ user.getAttributes().keySet());
		System.out.println("username-->"+ name);
		System.out.println("email-->"+ email);
	
		
       httpSession.setAttribute("UserSession", user);   
      	response.setStatus(HttpServletResponse.SC_OK);
  		 
      	 System.out.println("main 페이지로");
      	 
      	 response.sendRedirect("/loginSuccess");
     
	}

	 protected void clearAuthenticationAttributes(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
