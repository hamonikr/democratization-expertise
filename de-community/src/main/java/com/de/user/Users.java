package com.de.user;


import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.de.score.Score;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Entity
@Embeddable
@Table(name = "tb_users")
public class Users implements Serializable {

	@Id
	@Column(name = "userno")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	/* 회원 고유 번호 */
	private Integer userno;
	/* 회원 아이디 */
	private String userid;
	/* 회원 이름 */
	private String username;
	/* 회원 비밀번호 */
	private String userpassword;
	/* 프로필 이미지 */
	private String userprofileimg;
	/* 프로필 이미지 */
	private String picture;
	/* 회원 소개 */
	private String aboutme;
	/* 회원 사이트 주소 */
	private String userurl;
	/* 회원 지역 */
	private String location;
	/* 회원 이메일 */
	private String useremail;
	/* 회원 역할 */
	private int role;
	/* 회원 구분 0:관리자 1:일반유저 */
	private Integer userstatus;
	/* 뉴스레터 */
	private String newslater;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;
	/* 회사 대표 계정 여부 : 일반:0, 대표:1, 하위:2 */
	private Integer representat;
	/* 페이징 */
	@Transient
	private int firstRecordIndex;
	@Transient
	private int recordCountPerPage;

//	@JoinTable(name = "tb_users_detail", //조인테이블명
//		joinColumns = @JoinColumn(name="userno")  //외래키
//		//inverseJoinColumns = @JoinColumn(name="userno") //반대 엔티티의 외래키
//	)

//	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//	@JoinColumn(name= "userno")
	@Transient
	private UsersDetail usersDetail;

	@Transient
	private Score score;

//	@OneToOne
//	@JoinTable(name = "tb_score", //조인테이블명
//		joinColumns = @JoinColumn(name="userno"),  //외래키
//		inverseJoinColumns = @JoinColumn(name="userno") //반대 엔티티의 외래키
//	)
//	private UsersDetail userScore;

	/* 정렬 */
	private Integer sort;
	/* 검색 */
	private String searchtext;

}