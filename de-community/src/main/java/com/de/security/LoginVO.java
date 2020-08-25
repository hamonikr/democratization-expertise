package com.de.security;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Table(name="tb_users")
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class LoginVO {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private String user_id;	
	private String user_name;
	private String user_password;
	private String user_email;
	private String role;
}
