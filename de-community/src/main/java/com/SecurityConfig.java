package com;


import javax.servlet.Filter;

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
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

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

	@Autowired
	MemberService service;

//	@Autowired
//	OAuth2ClientContext oauth2ClientContext;

	@Autowired
	private OAuth2Filter filter;

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}


	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/dist/**", "/js/**", "images/**", "/plugins/**", "/tui-editor/**", "/paper-bw/**",
				"lib/**", "/css/**", "/img/**", "/fonts/**").and().httpFirewall(defaultHttpFirewall());
	}
	@Bean
	public HttpFirewall defaultHttpFirewall() {
	    return new DefaultHttpFirewall();
	}


	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security config-----------!!!");
		log.info("security config log===>");

		http.csrf().ignoringAntMatchers("/api/**", "/signup/**", "/login/**", "/applogin/**", "/wiki/**", "/accountRecovery/**",
				"/newsletters/**", "/cmmn/**");

		http.authorizeRequests().antMatchers("/users/userInfo").hasRole("USER").antMatchers("/**").permitAll().and()
				.addFilterBefore(ssoFilter(), BasicAuthenticationFilter.class).formLogin().loginPage("/login")
				.loginProcessingUrl("/login").defaultSuccessUrl("/").successHandler(authSuccessHandler)
				.failureForwardUrl("/login").failureHandler(customAccessDeniedHandler).and().logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/login/logout")).logoutSuccessUrl("/login")
				.invalidateHttpSession(true);

	}


	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(service).passwordEncoder(passwordEncoder());
	}


	@Bean
	public Filter ssoFilter() {
		System.out.println("fil2222222222222222==="+ filter.ssoFilter());
		return filter.ssoFilter();
	}

//	@Bean
//	public JwtAuthenticationFilter jwtFilter() {
//		return new JwtAuthenticationFilter();
//	}
}