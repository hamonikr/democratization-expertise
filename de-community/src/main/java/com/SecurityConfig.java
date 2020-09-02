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
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import com.AuthSuccessHandler;
import com.CustomAccessDeniedHandler;
import com.de.login.service.MemberService;;

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
	
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
	@Override
	public void configure(WebSecurity web) throws Exception {
		web
			.ignoring()
				.antMatchers("/dist/**", "/js/**", "images/**", "/wiki/**", "/plugins/**", "/tui-editor/**", "/paper-bw/**", "lib/**", "/css/**", "/img/**", "/fonts/**");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("security config-----------!!!");
		log.info("security config log===>");
		
		http.csrf().ignoringAntMatchers("/api/**","/signup/**","/login/**","/accountRecovery/**");
		
		http.authorizeRequests()
			.antMatchers("/users/userInfo").hasRole("USER")
			.antMatchers("/**").permitAll()
		.and()
			.formLogin()
				.loginPage("/login").loginProcessingUrl("/login")
				.defaultSuccessUrl("/").successHandler(authSuccessHandler)
		    	.failureForwardUrl("/login").failureHandler(customAccessDeniedHandler)
		.and()
			.logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/login/logout"))
				.logoutSuccessUrl("/login")
				.invalidateHttpSession(true);
				
			
	}
	@Autowired
	    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
	        auth.userDetailsService(service).passwordEncoder(passwordEncoder());
	    }
}
