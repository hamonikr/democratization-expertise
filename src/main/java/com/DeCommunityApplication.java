package com;

import java.nio.charset.Charset;
import java.util.Locale;

import javax.servlet.Filter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;

@SpringBootApplication
public class DeCommunityApplication {

	public static void main(String[] args) {
		SpringApplication.run(DeCommunityApplication.class, args);
	}
	
	@Bean
	public HttpMessageConverter<String> responseBodyConverter() {
		return new StringHttpMessageConverter(Charset.forName("UTF-8"));
	}

	@Bean
	public Filter characterEncodingFilter() {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		return characterEncodingFilter;
	}

	@Bean
	public HiddenHttpMethodFilter hiddenHttpMethodFilter() {
		HiddenHttpMethodFilter filter = new HiddenHttpMethodFilter();
		return filter;
	}

	
//	@Bean
//	public EmbeddedServletContainerCustomizer containerCustomizer() {
//		return new EmbeddedServletContainerCustomizer() {
//
//			@Override
//			public void customize(ConfigurableEmbeddedServletContainer container) {
//				ErrorPage error403Page = new ErrorPage(HttpStatus.FORBIDDEN, "/error-404.html");
//				ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/error-404.html");
//				ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error-404.html");
//
//				container.addErrorPages(error403Page, error404Page, error500Page);
//			}
//		};
//	}
	
	@Bean 
	public MessageSource messageSource(){ 
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource(); 
		messageSource.setBasename("classpath:/message/message"); 
		messageSource.setDefaultEncoding("UTF-8"); 
		messageSource.setCacheSeconds(180);
		Locale.setDefault(Locale.getDefault()); 
		
		return messageSource;
		}

}
