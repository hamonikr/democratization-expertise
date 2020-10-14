package com.hamonize.sample.service;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SampleVO {

	/* 순번 */
	private Integer seq = 0;
	/* 게시물 제목 */
	private String titl = "";
	/* 게시물 내용 */
	private String ctnt = "";
	/* 등록자 아이디 */
	private String user_id = "";
	/* 등록자 이름 */
	private String user_nm = "";
	/* 등록자 아이피 */
	private String user_ip = "";
	/* 등록자 이메일 */
	private String user_email = "";
	/* 등록자 전화번호 */
	private String user_tel = "";
	/* 등록자 핸드폰번호 */
	private String user_hp = "";
	/* 등록자 주소 */
	private String user_addr = "";
	/* 등록 일시 */
	private Date reg_date;
	/* 수정 일시 */
	private Date updt_date;
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
