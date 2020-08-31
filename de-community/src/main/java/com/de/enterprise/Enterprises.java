package com.de.enterprise;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_enterprises")
public class Enterprises {
	
	@Id
	@Column
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	/* 기업 고유 번호 */
	private Integer enterpriseno;
	/* 기업 승인 여부 */
	private Integer enterpriseat;
	/* 기업 아이디 */
	private String enterpriseid;
	/* 기업 이름 */
	private String enterprisename;
	/* 기업 비밀번호 */
	private String enterprisepassword;
	/* 기업 이메일 */
	private String enterpriseemail;
	/* 기업 사업자 번호 */
	private Integer enterprisebizno;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;

}
