package com.hamonize.login.service;


import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class LoginVO extends User {

	/** 
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String user_id; // 멤버 아이디
	private String user_passwd; // 멤버 비밀번호

	public LoginVO(LoginVO vo, Collection<? extends GrantedAuthority> authorities) {
		super(vo.getUser_id(), vo.getPassword(), authorities);
		// TODO Auto-generated constructor stub
	}

}
