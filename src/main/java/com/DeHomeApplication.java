package com;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.de.signup.mapper.SignupMapper")
public class DeHomeApplication {

	public static void main(String[] args) {
		SpringApplication.run(DeHomeApplication.class, args);
	}

}
