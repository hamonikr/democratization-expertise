package com.hamonize.license.service.vo;


import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class LicenseVO {

	// license company info
	private Integer seq;
	private Integer upper_seq;
	private String bizcd;
	//private String license_title;
	private String license_cd;
	private String business_code;
	private String license_no;
	//private Integer license_count;
	//private String fn_license_count;
	private Date reg_date;
	private Date updt_date;
	private List<String> bizlncsList;
	private String license_pd_st;
	private String license_pd_ed;
	private Date used;

	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
