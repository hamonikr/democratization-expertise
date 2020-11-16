package com.de.sample;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;

@Configuration
@PropertySources({
   @PropertySource( value = "file:/home/hamonikr/git/etc/config.properties", ignoreResourceNotFound = true ),
   @PropertySource( value = "file:C:/env/config.properties", ignoreResourceNotFound = true)
})
public class GlobalPropertySource {
	//db
   @Value("${spring.datasource.driverClassName}")
   private String driverClassName;
   
   @Value("${spring.datasource.url}")
   private String url;
   
   @Value("${spring.datasource.username}")
   private String username;
   
   @Value("${spring.datasource.password}")
   private String password;

   //google
//   @Value("${google.client.clientId}")
//   private String clientId;
//   
//   @Value("${google.client.clientSecret}")
//   private String clientSecret;
// 
//   //github
//   @Value("${custom.oauth2.github.client-id}")
//   private String githubClientId;
//   
//   @Value("${custom.oauth2.github.client-secret}")
//   private String githubClientSecret;
//      
//   
//   //naver
//   @Value("${custom.oauth2.naver.client-id}")
//   private String naverClientId;
//   
//   @Value("${custom.oauth2.naver.client-secret}")
//   private String naverClientSecret;
//   
//   //kakao
//   @Value("${custom.oauth2.kakao.client-id}")
//   private String kakaoClientId;
//   
//   @Value("${custom.oauth2.kakao.client-secret}")
//   private String kakaoClientSecret;

   
   public String getDriverClassName() {
       return driverClassName;
   }   
   
   public String getUrl() {
       return url;
   }

   public String getUsername() {
       return username;
   }

   public String getPassword() {
       return password;
   }

//   public String getClientId() {
//       return clientId;
//   }
//
//   public String getClientSecret() {
//       return clientSecret;
//   }
//
//   public String getGithubClientId() {
//       return githubClientId;
//   }
//
//   public String getGithubClientSecret() {
//       return githubClientSecret;
//   }
//   public String getNaverClientId() {
//       return naverClientId;
//   }
//
//   public String getNaverClientSecret() {
//       return naverClientSecret;
//   }
//   public String getKakaoClientId() {
//       return kakaoClientId;
//   }
//
//   public String getKakaoClientSecret() {
//       return kakaoClientSecret;
//   }
   
}

