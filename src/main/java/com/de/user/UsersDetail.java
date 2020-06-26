package com.de.user;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_users_detail")
public class UsersDetail {
	
	/* 기업 번호 */
	private Integer enterpriseNo;
	/* 유저 번호 */
	private Integer userNo;
	/* 유저 승인여부 */
	private Integer userAt;
	/* 유저 활성여부 */
	private Integer activeAt;

}
