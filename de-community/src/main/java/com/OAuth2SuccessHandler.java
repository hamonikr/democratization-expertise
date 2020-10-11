package com;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.GoogleUser;

@Configuration
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler{
	
	@Autowired
	private CmmnService cmmnService;
	
	 //google
	  @Value("${google.client.clientId}")
	  private String clientId;
	
	  //github
	  @Value("${github.client.client-id}")
	  private String githubClientId;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		 OAuth2Authentication oAuth2Authentication = (OAuth2Authentication) authentication;

		 ObjectMapper objectMapper = new ObjectMapper();
		GoogleUser googleUser = objectMapper.convertValue(oAuth2Authentication.getUserAuthentication().getDetails(),  GoogleUser.class);
		HttpSession httpSession = request.getSession(true);    	 
        CmmnMap param = new CmmnMap();    
        int result = 0;
		if(oAuth2Authentication.getOAuth2Request().getClientId().equals(clientId)) {       
	        param.put("userid",googleUser.getEmail());
	        param.put("username", googleUser.getName());
	        param.put("picture", googleUser.getPicture());
	        param.put("role", 2);
	        googleUser.setUserid(googleUser.getEmail());
		}else if(oAuth2Authentication.getOAuth2Request().getClientId().equals(githubClientId)) {
			param.put("userid",googleUser.getLogin());
	        param.put("username", googleUser.getName());
	        param.put("picture",googleUser.getAvatar_url());
	        param.put("role", 2);
	        googleUser.setUserid(googleUser.getLogin());
		}
		try {
			result = cmmnService.selectCount("socialUserCheck", param);
			
			if(result <= 0) {
				cmmnService.insertObject("socialUserSave", param);
			}
			httpSession.setAttribute("userSession", googleUser);   
	     	 response.setStatus(HttpServletResponse.SC_OK);	
			response.sendRedirect("/login/socialLogin");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

       
        clearAuthenticationAttributes(request);
		
	}
	
	 protected void clearAuthenticationAttributes(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
