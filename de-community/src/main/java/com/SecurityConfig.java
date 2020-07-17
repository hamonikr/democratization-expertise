package com;


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

import com.de.login.service.CustomUserDetailsService;


@Configuration
@EnableWebSecurity
@EnableGlobalAuthentication
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	CustomUserDetailsService customUserDetailsService;

	@Autowired
	AuthSuccessHandler authSuccessHandler;
	
	@Autowired
	CustomAccessDeniedHandler customAccessDeniedHandler;

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/dist/**", "/js/**", "images/**", "/plugins/**", "/tui-editor/**", "/paper-bw/**", "lib/**", "/css/**", "/img/**", "/fonts/**");
//				,"/restapi/**");
	}


	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().ignoringAntMatchers("/login/**","/signup/**");
		http
			.authorizeRequests()
				.antMatchers("/sample/**", "/jsd/**", "/test/**", "/signup/**").permitAll()			
				// All User
				.antMatchers("/login/**").permitAll()
				// Admin
				.antMatchers("/login/signin").hasRole("ADMIN")
				// Member
				.antMatchers("/login/signin").hasRole("MEMBER")
				// 그외 모든 요청은 인증된 사용자만 접근 가능
				.anyRequest().authenticated()
				// 로그인 설정
				.and()
				// move login success after page
				.formLogin()
					.loginPage("/login/login")
					.loginProcessingUrl("/login/signin")
					.defaultSuccessUrl("/sample/list", true).successHandler(authSuccessHandler)
					.failureForwardUrl("/login/login").failureHandler(customAccessDeniedHandler)
				.and()
				// logout setting
				.logout()
					.logoutUrl("/login/logout")
					.logoutSuccessUrl("/login/login")
					.invalidateHttpSession(true)
					.deleteCookies("JSESSIONID");
	}


	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}


	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder());
	}

}
