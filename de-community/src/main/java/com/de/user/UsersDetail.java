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
	/* 기업 번호 not 사업자번호 */
	private Integer enterpriseno;
	/* 유저 번호 */
	private Integer userno;
	/* 유저 승인여부 : 없음, 대기0, 승인1, 거부:2 */
	private Integer userat;
	/* 유저 활성여부 ㅣ 활성: 0, 비활성:1*/
	private Integer activeat;
	/* 회사 대표 계정 여부 : 없음, 일반:0, 대표:1 */
	private Integer representat;
}
