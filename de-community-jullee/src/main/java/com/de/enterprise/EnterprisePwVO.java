package com.de.enterprise;

import lombok.Data;

@Data
public class EnterprisePwVO {
	/* 파트너사고유 번호 */
	private Integer enterpriseno;
	/* 파트너사비밀번호 */
	private String enterprisepassword;
	/* 파트너사 새 비밀번호 */
	private String enterprisepasswordnew;
}