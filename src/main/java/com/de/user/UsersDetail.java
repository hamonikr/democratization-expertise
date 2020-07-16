package com.de.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
	
	/* 고유 번호 */
	@Id
	@Column
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer seq;
	/* 기업 번호 */
	private Integer enterpriseNo;
	/* 유저 번호 */
	private Integer userNo;
	/* 유저 승인여부 */
	private Integer userAt;
	/* 유저 활성여부 */
	private Integer activeAt;

}
