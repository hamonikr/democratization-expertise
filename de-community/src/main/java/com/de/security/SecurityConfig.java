package com.de.security;


import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

import com.AuthSuccessHandler;
import com.CustomAccessDeniedHandler;
import com.de.security.service.CustomOAuth2UserService;
import com.de.security.service.MemberService;

import static com.de.security.SocialType.*;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;

@Log
@Configuration
@EnableWebSecurity
@EnableGlobalAuthentication
@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	AuthSuccessHandler authSuccessHandler;

	@Autowired
	CustomAccessDeniedHandler customAccessDeniedHandler;	
	private MemberService memberService;
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web
			.ignoring()
				.antMatchers("/dist/**", "/js/**", "images/**", "/plugins/**", "/tui-editor/**", "/paper-bw/**", "lib/**", "/css/**", "/img/**", "/fonts/**");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security config-----------!!!");
		log.info("security config log===>");
		http
			.csrf().ignoringAntMatchers("/restapi/**","/signup/**","/login","/loginSuccess","/accountRecovery/**");
		
		http
			.authorizeRequests()  			
			.antMatchers("/oauth2/**", "/loginSuccess","/account-recovery","/", "/home", "/login/**","/signup/**","/sample/**","/questions/**","/vote/**").permitAll()			
				.antMatchers("/github").hasAuthority(GITHUB.getRoleType())
			    .antMatchers("/google").hasAuthority(GOOGLE.getRoleType())
				.antMatchers("/kakao").hasAuthority(KAKAO.getRoleType()) 
				.antMatchers("/naver").hasAuthority(NAVER.getRoleType())
				.anyRequest().authenticated()
			.and()
			    .oauth2Login() 
			    	.userInfoEndpoint()
			    		.userService(new CustomOAuth2UserService())		

			.and() 
				.defaultSuccessUrl("/loginSuccess",true).successHandler(authSuccessHandler)
				.failureUrl("/loginFailure").failureHandler(customAccessDeniedHandler)
			.and()
				.logout()
					.logoutUrl("/logout")
					.logoutSuccessUrl("/")
					.invalidateHttpSession(true)
					.deleteCookies("JSESSIONID")
			.and()
				.exceptionHandling() 
		    	.authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"));
	}
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());
	}
	
	@Bean 
	public ClientRegistrationRepository clientRegistrationRepository( 
	                    OAuth2ClientProperties oAuth2ClientProperties, 
	                    @Value("${custom.oauth2.github.client-id:}") String githubClientId, 
	                    @Value("${custom.oauth2.github.client-secret}") String githubClientSecret, 
	                    @Value("${custom.oauth2.kakao.client-id}") String kakaoClientId, 
	                    @Value("${custom.oauth2.kakao.client-secret}") String kakaoClientSecret, 
	                    @Value("${custom.oauth2.naver.client-id}") String naverClientId, 
	                    @Value("${custom.oauth2.naver.client-secret}") String naverClientSecret) { 
	
					List<ClientRegistration> registrations = oAuth2ClientProperties 
	                        .getRegistration().keySet().stream() 
	                        .map(client -> getRegistration(oAuth2ClientProperties, client)) 
	                        .filter(Objects::nonNull) 
	                        .collect(Collectors.toList()); 
					
					 registrations.add(CustomOAuth2Provider.GITHUB.getBuilder("github") 
	                        .clientId(githubClientId)
	                        .clientSecret(githubClientSecret) 
	                        .jwkSetUri("temp").build()); 
					
	                registrations.add(CustomOAuth2Provider.KAKAO.getBuilder("kakao") 
	                        .clientId(kakaoClientId)
	                        .clientSecret(kakaoClientSecret) 
	                        .jwkSetUri("temp").build()); 
	                
	                registrations.add(CustomOAuth2Provider.NAVER.getBuilder("naver") 
	                        .clientId(naverClientId) 
	                        .clientSecret(naverClientSecret) 
	                        .jwkSetUri("temp").build()); 
	                
	                return new InMemoryClientRegistrationRepository(registrations); 
	    }

	 private ClientRegistration getRegistration(OAuth2ClientProperties clientProperties, String client) {
	     if("google".equals(client)) {
	         OAuth2ClientProperties.Registration registration = clientProperties.getRegistration().get("google");
	        
	         return CommonOAuth2Provider.GOOGLE.getBuilder(client) 
	                .clientId(registration.getClientId()) 
	                .clientSecret(registration.getClientSecret()) 
	                .scope("email", "profile").build(); 
	        }

	         return null; 
	    }
	
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

//
//	@Autowired
//	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//		
//		auth
//			.userDetailsService(memberServices)
//			.passwordEncoder(passwordEncoder());
//
//	}

	
}
