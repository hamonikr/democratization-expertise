package com.hamonize.license.service.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class LicenseBizVO {

	// license company info
	private Integer seq;
	private String bizcd;
	private String contract;
	private String supply_name;
	private String demand_name;
	private String license_period;
	private String register_id;
	private String bizno1;
	private String bizno2;
	private String bizno3;
	private String bizno;
	private String license_cd;
	private Date reg_date;
	private Date updt_date;
	private String lcns_st;
	private String lcns_dt;
	private String license_title;
	private String biz_license_cnt; // db
	private Integer license_count;
	private String business_code;

	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
