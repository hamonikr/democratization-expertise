package com.de.login;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Embeddable;
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
@Embeddable
@Table(name = "tb_users")
public class Login implements Serializable{
	
	@Id
	@Column(name="userno")
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	/* 회원 고유 번호 */
	private Integer userno;
	/* 회원 아이디 */
	private String userid;
	/* 회원 이름 */
	private String username;
	/* 회원 비밀번호 */
	private String userpassword;
	/* 회원 소개 */
	private String aboutme;
	/* 회원 사이트 주소 */
	private String userurl;
	/* 회원 이메일 */
	private String useremail;
	/* 회원 구분 1:회원가입 2:소셜가입  - 소셜가입은 패스워드 없고 정보만 저장*/
	private Integer userstatus;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;
}
	
