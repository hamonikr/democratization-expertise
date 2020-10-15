package com.hamonize.estimate.service;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class EstimateVO {

	/* 순번 */
	private Integer seq = 0;
	/* 업체 코드 */
	private String bizcd = "";
	/* 업체 이름 */
	private String biznm = "";
	/* 견적 가격 */
	private int price = 0;
	/* 게시물 제목 */
	private String subject = "";
	/* 등록자 아이디 */
	private String writer_id = "";
	/* 등록자 이름 */
	private String writer_name = "";
	/* 등록자 내용 */
	private String content = "";
	/* 등록 일시 */
	private Date register_date;
	/* 수정 일시 */
	private Date update_date;
	/* 승인 여부 1: 승인 0: 미승인 */
	private int consent = 0;
	/* 승인 일시 */
	private Date consent_date;
	/* 삭제 여부 1: 삭제 0: 활성 */
	private int delete_at = 0;
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
