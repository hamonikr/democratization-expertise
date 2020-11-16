package com.de.login.service;

import java.util.HashSet;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.de.login.vo.Role;
import com.de.login.vo.LoginVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SecurityMember extends User {
	private static final long serialVersionUID = 1L;

	private int userno; // 멤버 아이디
	private String userid; // 멤버 아이디
	private String userpassword; // 멤버 비밀번호
	private String username; // 멤버 이름
	private String useremail; // 멤버 이메일
	private int role; // 멤버권한
	private int activeat; // 계정 활성상태 0:활성, 1:비활성
	private int enterpriseno;
	private int representat; // 대표계졍 여부 :1이면 대표,0이면 일반 
	private String enterprisename;
	
	// session setter
		public SecurityMember(LoginVO vo) {
			super(vo.getUserid(), vo.getUserpassword(), makeGrantedAuthority(vo));	
			this.userno = vo.getUserno();
			this.userid = vo.getUserid();
			this.userpassword = vo.getUserpassword();
			this.username = vo.getUsername();
			this.useremail = vo.getUseremail();
			this.role = vo.getRole();
			this.activeat = vo.getActiveat();
			this.enterpriseno = vo.getEnterpriseno();
			this.representat = vo.getRepresentat();
			this.enterprisename = vo.getEnterprisename();
		}
		
		private static Set<GrantedAuthority> makeGrantedAuthority(LoginVO vo) {
			Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
			
			if (vo.getRole()== 0) {
					grantedAuthorities.add(new SimpleGrantedAuthority(Role.ADMIN.getValue()));
				}	else if (vo.getRole()!=0) {
						grantedAuthorities.add(new SimpleGrantedAuthority(Role.USER.getValue()));
				}
			return grantedAuthorities;
		}
}
