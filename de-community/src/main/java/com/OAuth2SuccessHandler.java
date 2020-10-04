package com;

import java.io.IOException;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.de.login.service.GoogleUser;

public class OAuth2SuccessHandler implements AuthenticationSuccessHandler{
	
	private HttpSession httpSession;
    private ObjectMapper objectMapper;

    public OAuth2SuccessHandler(HttpSession httpSession, ObjectMapper objectMapper) {
        this.httpSession = httpSession;
        this.objectMapper = objectMapper;
    }

    private GoogleUser getGoogleUser(Authentication authentication) { // OAuth 인증정보를 통해 GoogleUser 인스턴스 생성
        OAuth2Authentication oAuth2Authentication = (OAuth2Authentication) authentication;
        return objectMapper.convertValue(oAuth2Authentication.getUserAuthentication().getDetails(), GoogleUser.class);
    }

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		OAuth2Authentication oAuth2Authentication = (OAuth2Authentication) authentication; 
//		Map<String, Object> goo = new LinkedHashMap<>();
//		goo.put("profile", objectMapper.convertValue(oAuth2Authentication.getUserAuthentication().getDetails(),GoogleUser.class));
//		System.out.println("aaaaaa======="+oAuth2Authentication.getUserAuthentication().getDetails().toString());
		//httpSession.setAttribute("user", getGoogleUser(authentication)); // 간단한 구글계정 정보를 세션에 저장
        response.sendRedirect("/users/activity/4");
		
	}

}
