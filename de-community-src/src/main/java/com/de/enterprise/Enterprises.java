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
	private Integer enterpriseNo;
	/* 기업 승인 여부 */
	private Integer enterpriseAt;
	/* 기업 아이디 */
	private String enterpriseId;
	/* 기업 이름 */
	private String enterpriseName;
	/* 기업 비밀번호 */
	private String enterprisePassword;
	/* 기업 이메일 */
	private String enterpriseEmail;
	/* 기업 사업자 번호 */
	private Integer enterpriseBizno;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

}
