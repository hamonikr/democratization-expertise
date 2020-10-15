package com.hamonize.login.service;


import java.util.HashSet; 
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.hamonize.user.service.UserRole;
import com.hamonize.user.service.UserVO;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class SecurityMember extends User {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String bizcd;
	private String biznm;
	private String user_id;
	private String user_nm;
	private String user_ip;
	private String user_email;
	private String user_hp;
	private String user_role;
	private String user_rank;
	private String user_dept;
	private String reg_date;
	private String updt_date;
	private String proc_stat;
	private String biz_auth_role;

	
	// session setter
	public SecurityMember(UserVO vo) {
		super(vo.getUser_id(), vo.getUser_passwd(), makeGrantedAuthority(vo));
		this.bizcd = vo.getBizcd();
		this.biznm = vo.getBiznm();
		this.user_id = vo.getUser_id();
		this.user_nm = vo.getUser_nm();
		this.user_ip = vo.getUser_ip();
		this.user_email = vo.getUser_email();
		this.user_hp = vo.getUser_hp();
		this.user_rank = vo.getUser_rank();
		this.user_dept = vo.getUser_dept();
		this.user_role = vo.getUser_role();
		this.proc_stat = vo.getProc_stat();
		this.biz_auth_role = vo.getBiz_auth_role();
	}


	private static Set<GrantedAuthority> makeGrantedAuthority(UserVO vo) {
		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();

//		if(vo.getUser_auth_role().equals("1"))
//			grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));
//		else if(!vo.getUser_auth_role().equals("1"))
//			grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.MEMBER.getValue()));

		if (vo.getBiz_auth_role().equals("1"))
			grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));
		else if (!vo.getBiz_auth_role().equals("1"))
			grantedAuthorities.add(new SimpleGrantedAuthority(UserRole.MEMBER.getValue()));
		return grantedAuthorities;
	}

}
