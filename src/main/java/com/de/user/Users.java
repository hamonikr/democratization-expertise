package com.de.user;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToOne;
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
@Table(name = "tb_users")
public class Users {
	
	@Id
	@Column(name="user_no")
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	/* 회원 고유 번호 */
	private Integer userNo;
	/* 회원 아이디 */
	private String userId;
	/* 회원 이름 */
	private String userName;
	/* 회원 비밀번호 */
	private String userPassword;
	/* 회원 소개 */
	private String aboutMe;
	/* 회원 사이트 주소 */
	private String userUrl;
	/* 회원 이메일 */
	private String userEmail;
	/* 회원 구분 1:회원가입 2:소셜가입  - 소셜가입은 패스워드 없고 정보만 저장*/
	private Integer userStatus;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

	@OneToOne
	@JoinTable(name="tb_user_detail")
	@JoinColumn(name="user_no")
	UsersDetail usersDetail;
}
