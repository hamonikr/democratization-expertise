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

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.login.service.SecurityMember;


@Configuration
public class AuthSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private CmmnService cmmnService;
	
	@Autowired
	private MessageSource messageSource;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		// 세션을 가져온다. (가져올 세션이 없다면 생성한다.)
        HttpSession httpSession = request.getSession(true);
        CmmnMap param = new CmmnMap();
        param.put("user_id",request.getParameter("username"));
        try {
			cmmnService.insertObject("login_history", param);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        //error session delete
        clearAuthenticationAttributes(request);
        SecurityMember user = (SecurityMember) authentication.getPrincipal();
        System.out.println("proc======"+user.getProc_stat());
        System.out.println("hp======"+user.getUser_hp());

        if("Y".equals(user.getProc_stat())) {
//            // "UserSession"로 user를 세션에 바인딩한다.
//          		httpSession.setAttribute("UserSession", user);
//          		response.setStatus(HttpServletResponse.SC_OK);
//          		response.sendRedirect("/main/index");

          		
        	httpSession.setAttribute("UserSession", user);
      		response.setStatus(HttpServletResponse.SC_OK);
      		
      		if("nullnullnull".equals(user.getUser_hp())) {
      		request.setAttribute("message", messageSource.getMessage("common.login.first", null, Locale.getDefault()));
        	request.setAttribute("url", "/signup/subUserEditForm.ivs");
        	request.getRequestDispatcher("/sign/message").forward(request, response);
      		}else {
      		    response.sendRedirect("/main/index");
      		}

        }else {
        	request.setAttribute("message", messageSource.getMessage("common.login.fail", null, Locale.getDefault()));
        	request.setAttribute("url", "/sign/login");
        	request.getRequestDispatcher("/sign/message").forward(request, response);
            //response.sendRedirect("/sign/login?result="+user.getProc_stat());
        }
	}

	 protected void clearAuthenticationAttributes(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
