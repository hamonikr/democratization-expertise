package com;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@MapperScan("com.de.signup.mapper.SignupMapper")

@SpringBootApplication
public class DeHomeApplication {

	public static void main(String[] args) {
		SpringApplication.run(DeHomeApplication.class, args);
	}

}
