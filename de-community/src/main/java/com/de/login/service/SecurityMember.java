package com.de.login.service;


import java.util.HashSet; 
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.de.login.Login;
import com.de.user.UserRole;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class SecurityMember extends User {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int userNo;
	private String userId;
	private String userPassword;
	private String userEmail;
	private String userName;
	private int userStatus;
	private int enterpriseNo;
	// session setter
	public SecurityMember(Login vo) {
		super(vo.getUserId(), vo.getUserPassword(), makeGrantedAuthority(vo));
		this.userNo = vo.getUserNo();
		this.userId = vo.getUserId();
		this.userPassword = vo.getUserPassword();
		this.userEmail = vo.getUserEmail();
		this.userName = vo.getUserName();
//		this.userStatus = vo.getUserStatus();
		//this.enterpriseNo = uvo.getEnterpriseNo();
		
	}


	private static Set<GrantedAuthority> makeGrantedAuthority(Login vo) {
		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
		grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.MEMBER.getValue()));

		System.out.println("makeGrantedAuthority==>" + grantedAuthorities.toString());
//		if (uvo.getEnterpriseNo() != null) {
//			grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.MEMBER.getValue()));
//			} else {
//				grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.MEMBER.getValue()));
//			}
		return grantedAuthorities;
	}

}
