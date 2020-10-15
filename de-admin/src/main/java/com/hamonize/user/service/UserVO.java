package com.hamonize.user.service;


import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.hamonize.login.service.LoginVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class UserVO{

	private int seq; // 멤버 고유번호
	private String user_id; // 멤버 아이디
	private String user_passwd; // 멤버 비밀번호
	private String user_nm; // 멤버 이름
	private String user_hp; // 멤버 셀폰
	private String user_addr; // 멤버 주소
	private String user_email; // 멤버 이메일
	private String user_company; // 멤버 회사
	private String user_auth_role; // 멤버 권한
	private String user_rank; // 멤버 직급
	private String user_dept; // 멤버 부서
	private String user_role; // 관리자 권한 구분
	private Date reg_date; // 가입일
	private Date updt_date; // 수정일

	private String biz_auth_role;
	private String bizcd;
	private String biznm;
	private String user_ip;
	private String proc_stat;
	
}
