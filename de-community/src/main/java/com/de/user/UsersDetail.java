package com.de.user;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
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
	/* 유저 회사 승인여부 :  디폴트: 0, 승인(활성):1, 거부:2 , 비활성:3*/
	private Integer userat;
	/* 유저 계정 활성여부 ㅣ 활성: 0, 비활성:1*/
	private Integer activeat;
	/* 회사 대표 계정 여부 : 일반:0, 대표:1, 하위:2 */
	private Integer representat;
	
	@OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userno" ,insertable = false, updatable = false)
    private Users users;
}
