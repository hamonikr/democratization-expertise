package com;


import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.de.login.service.MemberService;
import com.de.login.service.MemberService;

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

	private MemberService memberServices;

	@Override
	public void configure(WebSecurity web) throws Exception {

		web.ignoring().antMatchers("/dist/**","/js/**", "images/**", "/plugins/**",
				"/tui-editor/**", "/paper-bw/**", "lib/**", "/css/**", "/img/**", "/fonts/**");
//				,"/restapi/**");
	}


	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security config-----------");
		log.info("security config log===>");
		
		http.csrf().ignoringAntMatchers("/login/**","/signup/**");
		http
			.authorizeRequests()
				.antMatchers("/test/**", "/signup/**","/oauth2/**","/sample/**").permitAll()			
				// All User
				.antMatchers("/login/**").permitAll()
				// Member
				.antMatchers("/login/signin").hasRole("MEMBER")
				.antMatchers("/login/naverCallback").hasRole("MEMBER")
				.antMatchers("/login/personalInfo").hasRole("MEMBER")

				// 그외 모든 요청은 인증된 사용자만 접근 가능
				.anyRequest().authenticated()
				// 로그인 설정
				.and()
				// move login success after page
				.formLogin()
					.loginPage("/login/login")
					.loginProcessingUrl("/login/signin")
					.loginProcessingUrl("/login/snsLogin")
					.defaultSuccessUrl("/sample/list", true).successHandler(authSuccessHandler)
					.failureForwardUrl("/login/login").failureHandler(customAccessDeniedHandler)
				.and()
				// logout setting
				.logout()
					.logoutUrl("/login/logout")
					.logoutSuccessUrl("/")
					.invalidateHttpSession(true)
					.deleteCookies("JSESSIONID");
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}


	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		
		auth
			.userDetailsService(memberServices)
			.passwordEncoder(passwordEncoder());

	}

}
