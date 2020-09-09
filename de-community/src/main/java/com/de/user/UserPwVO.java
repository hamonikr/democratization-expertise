package com.de.user;

import lombok.Data;

@Data
public class UserPwVO {
	/* 회원 고유 번호 */
	private Integer userno;
	/* 회원 비밀번호 */
	private String userpassword;
	/* 회원 새 비밀번호 */
	private String userpasswordnew;
}