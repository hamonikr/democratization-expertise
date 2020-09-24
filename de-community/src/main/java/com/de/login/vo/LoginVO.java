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
	
	/* 회사계정 */
	private int enterpriseno; 
	private int representat; //회사 대표여부 1:대표, 2:일반직원 ,0 (default): 일반유저
	private int userat; //회사등록 요청 여부 
}
