package com.de.user;


import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Entity
@Embeddable
public class Userslist implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "userno")
	private Integer userno;
	/* 회원 아이디 */
	private String userid;
	/* 회원 이름 */
	private String username;
	/* 프로필 이미지 */
	private String userprofileimg;
	/* 프로필 이미지 */
	private String picture;
	/* 회원 사이트 주소 */
	private String userurl;
//	private Integer userdislikes;
//	private Integer userlikes;
	private Integer totlikes;
	private Integer userscore;

}