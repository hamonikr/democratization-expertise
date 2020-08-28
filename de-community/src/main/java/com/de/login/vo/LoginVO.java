package com.de.login.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginVO {
	private int userno;
	private String userid; // 멤버 아이디
	private String userpassword; // 멤버 비밀번호
	private String username; // 멤버 이름
	private String useremail; // 멤버 이메일
	private int role; // 멤버 이메일
	private int activeat; // 계정 활성상태 0:활성, 1:비활성 
}
