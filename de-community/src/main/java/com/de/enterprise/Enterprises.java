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
	/* 기업 사업자 번호 */
	private Integer enterprisebizno;
	/* 기업 아이디 */
	private String enterpriseid;
	/* 기업 이름 */
	private String enterprisename;
	/* 기업 비밀번호 */
	private String enterprisepassword;
	/* 기업 프로필 이미지 */
	private String enterpriseimg;
	/* 기업 소개 */
	private String enterpriseabout;
	/* 기업 사이트 주소 */
	private String enterpriseurl;
	/* 기업 이메일 */
	private String enterpriseemail;
	/* 기업 승인 여부 */
	private Integer enterpriseat;
	/* 기업 지역 */
	private String enterprisearea;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;


	/* users no (seq)*/
	private Integer userno;
	/* 유저 승인여부 : 없음, 대기0, 승인1, 거부:2 */
	private Integer userat;
	/* 유저 활성여부 ㅣ 활성: 0, 비활성:1*/
	private Integer activeat;
	/* 회사 대표 계정 여부 : 없음, 일반:0, 대표:1 */
	private Integer representat;
	
	
}
