package com.hamonize.restApi.technicalsts.service.vo;


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
	private String bizcd;
	private String license_title;
	private String license_cd;
	private String license_no;
	private Integer license_count;
	private String fn_license_count;
	private Date reg_date;
	private Date updt_date;
	private List<String> bizlncsList;
	private String lcns_st;
	private String lcns_dt;
	private String usedUserLicenseUUID;

	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
