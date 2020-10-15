package com.hamonize.inquiry.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AssigneeVO {

	/* 수요사 회사코드 */
	private String bizcd;
	/* 수요사 이름 */
	private String biznm;
	/* 수요사 담당자 이름 */
	private String user_nm;

	
}
