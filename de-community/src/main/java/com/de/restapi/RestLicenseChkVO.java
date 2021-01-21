package com.de.restapi;


import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class RestLicenseChkVO {

	// license company info
	private Integer seq;
	private Integer pseq;
	private String bizcd;
	private String license_title;
	private String license_cd;
	private String license_no;
	private String machineId_val;
	private Integer license_count;
	private String fn_license_count;
	private Date reg_date;
	private Date updt_date;
	private List<String> bizlncsList;
	private String lcns_st;
	private String lcns_dt;
	private String usedUserLicenseUUID;

	/* 기술지원 */
	private String subject;
	private String ts_user;
	private String contents;
	private String tchnlgy_wait;
	private String tchnlgy_ing;
	private String tchnlgy_done;
	private String tchnlgy_total;
	private String proc_stat;
	private String comments;

	/* 공지 */
	private Integer notice_seq;
	private String target;
	private String title;
	private String notice_contents;
	private String notice_regdate;

	/* 만족도 */
	private Integer survey_seq;
	private Integer survey_score;
	private String survey_content;

	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
