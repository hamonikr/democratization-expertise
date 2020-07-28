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
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;


@Configuration
public class AuthSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private CmmnService cmmnService;
	
//	@Autowired
//	private MessageSource messageSource;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		System.out.println("login success---->");
		// 세션을 가져온다. (가져올 세션이 없다면 생성한다.)
        HttpSession httpSession = request.getSession(true);
        CmmnMap param = new CmmnMap();
        System.out.println("onAuthenticationSuccess -- username-->"+ request.getParameter("username"));
        param.put("username",request.getParameter("username")); 
        clearAuthenticationAttributes(request);
        SecurityMember user = (SecurityMember) authentication.getPrincipal();

        System.out.println("session user value-->" + user.toString());
        httpSession.setAttribute("UserSession", user);
      	 response.setStatus(HttpServletResponse.SC_OK);
  		System.out.println("sample 페이지로");
      	response.sendRedirect("/sample/list");
     
	}

	 protected void clearAuthenticationAttributes(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
