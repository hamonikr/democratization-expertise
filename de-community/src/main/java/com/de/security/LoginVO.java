package com.de.security;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
public class LoginVO {
	
	private String userid;
	private String username;
	private String userpassword;
	private String useremail;
	private String role;
}
