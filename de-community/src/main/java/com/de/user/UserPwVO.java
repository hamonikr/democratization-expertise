package com.de.user;

import lombok.Data;

@Data
public class UserPwVO {
	/* 회원 고유 번호 */
	private Integer userNo;
	/* 회원 비밀번호 */
	private String userPassword;
	/* 회원 새 비밀번호 */
	private String userPasswordNew;
}