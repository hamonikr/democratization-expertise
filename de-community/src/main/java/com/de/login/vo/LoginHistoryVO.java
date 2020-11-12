package com.de.login.vo;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class LoginHistoryVO {

	private int seq;
	private String userid; // 멤버 아이디
	private Date logintime; // 로그인 시간
	private Date logouttime; // 로그아웃 시간
	
}
