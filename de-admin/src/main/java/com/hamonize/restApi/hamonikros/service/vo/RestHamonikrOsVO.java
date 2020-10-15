package com.hamonize.restApi.hamonikros.service.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class RestHamonikrOsVO {

	private Integer seq;
	private String name;
	private String gubun;
	private String version;
	private String status;
	private Date reg_date;
	private Date updt_date;

	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
