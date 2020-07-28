package com;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
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
        	request.setAttribute("url", "/login/login");
        	request.setAttribute("message", "비밀번호가 올바르지 않습니다. 확인해주세요");
        	request.getRequestDispatcher("/login/message").forward(request, response);;
        } else if(exception instanceof InternalAuthenticationServiceException) {
        	request.setAttribute("url", "/login/login");
        }

	}
}
