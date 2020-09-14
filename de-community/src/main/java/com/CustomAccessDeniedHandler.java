package com;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
public class CustomAccessDeniedHandler implements AuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		System.out.println("CustomAccessDeniedHandler exception발생====>"+exception);
		
		if(exception instanceof BadCredentialsException) {
//        	request.setAttribute("url", "/login/login");
        	response.sendRedirect("/login");
        } else if(exception instanceof InternalAuthenticationServiceException) {
//        	request.setAttribute("url", "/");
        	response.sendRedirect("/login");
        }

	}
}
