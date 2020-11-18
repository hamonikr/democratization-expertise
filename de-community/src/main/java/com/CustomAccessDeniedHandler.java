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
	@Autowired
	private MessageSource messageSource;
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		System.out.println("CustomAccessDeniedHandler exception발생====>"+exception);
		
		if(exception instanceof BadCredentialsException) {
        	//request.setAttribute("url", "/");
			request.setAttribute("message", messageSource.getMessage("login.incorrect.pw", null, Locale.getDefault()));
        	request.setAttribute("url", "/login");
        	request.getRequestDispatcher("/login/message").forward(request, response);
        } else if(exception instanceof InternalAuthenticationServiceException) {
			request.setAttribute("message", messageSource.getMessage("login.incorrect.id", null, Locale.getDefault()));

        	request.setAttribute("url", "/login");
        	request.getRequestDispatcher("/login/message").forward(request, response);

        }

	}
}
