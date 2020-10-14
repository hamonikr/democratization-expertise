package com.hamonize.inquiry.service;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InquiryVO {

	/* 순번 */
	private Integer seq = 0;
	/* 원글 번호 */
	private Integer inquiry_seq = 0;
	/* 원글 번호 */
	private String subject = "";
	
	/* 제목 */
	private String title = "";
	/* 문의내용 */
	private String contents = "";
	
	/* 답글 내용 */
	private String comments = "";
	/* 등록일 */
	private Date reg_date;   
	/* 업데이트일 */
	private Date updt_date;
	/* 공급사 이름 */
	private String supply_name;
	/* 수요사 이름 */
	private String demand_name;
	/* 작성 사용자 이름 */
	private String ts_user;
	
	/* 작성글 처리 상태값 */
	private int proc_stat;
	
	/* 담당자 이름 */
	private String assignee;
	
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

	
}
