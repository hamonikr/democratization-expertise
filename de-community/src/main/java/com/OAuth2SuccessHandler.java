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
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.GoogleUser;


import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;


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
		
		System.out.println("onAuthenticationSuccess===");

		HttpSession session = request.getSession();
		String webAppGubun = (String) session.getAttribute("webAppGubun");
		System.out.println("zzzzzzzzzzzzzzzz=====urasdasdasdsi==========="+ webAppGubun  );
		
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		// 있을 경우 URI 등 정보를 가져와서 사용
		if (savedRequest != null) {
			String uri = savedRequest.getRedirectUrl();
			
			// 세션에 저장된 객체를 다 사용한 뒤에는 지워줘서 메모리 누수 방지
			requestCache.removeRequest(request, response);

			System.out.println(uri);
		}

		
		
		OAuth2Authentication oAuth2Authentication = (OAuth2Authentication) authentication;
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		
		
		System.out.println("3===========+"+  oAuth2Authentication.getName());
		System.out.println("2===========+"+ request);
		System.out.println("@@@@@@@@@@@@@@########==="+ oAuth2Authentication.getUserAuthentication().getDetails());
		GoogleUser googleUser = objectMapper.convertValue(oAuth2Authentication.getUserAuthentication().getDetails(),  GoogleUser.class);
		HttpSession httpSession = request.getSession(true);    	 
		
       CmmnMap param = new CmmnMap();    
       int result = 0;
       System.out.println("@111==="+ clientId);
       System.out.println("@222==="+ oAuth2Authentication.getOAuth2Request().getRequestParameters() );
       
       
		if(oAuth2Authentication.getOAuth2Request().getClientId().equals(clientId)) {
			System.out.println("zzzzzzzzzzzzzzzzzzzzz");
	        param.put("userid",googleUser.getEmail());
	        param.put("username", googleUser.getName());
	        param.put("picture", googleUser.getPicture());
	        param.put("role", 2);
	        googleUser.setUserid(googleUser.getEmail());
		}else if(oAuth2Authentication.getOAuth2Request().getClientId().equals(githubClientId)) {
			System.out.println("yyyyyyyyyyyyyyyyy");
			param.put("userid",googleUser.getLogin());
	        param.put("username", googleUser.getName());
	        param.put("picture",googleUser.getAvatar_url());
	        param.put("role", 2);
	        googleUser.setUserid(googleUser.getLogin());
		}
		try {
			
			
			result = cmmnService.selectCount("socialUserCheck", param);
			System.out.println("result===============++"+result);
			
			
			if(result <= 0) {
				cmmnService.insertObject("socialUserSave", param);
			}
			
			System.out.println("googlsuser====="+googleUser.getUserid());
			
			httpSession.setAttribute("googleId", googleUser.getUserid());
			httpSession.setAttribute("googleNm", googleUser.getName());   
			httpSession.setAttribute("googlePicture", googleUser.getPicture());   
	     	 response.setStatus(HttpServletResponse.SC_OK);
	     	 //request.setAttribute("googleUser", googleUser);
			
	     	 System.out.println("param==="+param);
	     	 response.sendRedirect("/login/socialLogin/" + webAppGubun );
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

       
        clearAuthenticationAttributesq(request);
		
	}
	
	 protected void clearAuthenticationAttributesq(HttpServletRequest request) {
	        HttpSession session = request.getSession(false);
	        if(session==null) return;
	        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

}
