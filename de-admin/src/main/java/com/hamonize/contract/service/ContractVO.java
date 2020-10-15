package com.hamonize.contract.service;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class ContractVO {

	/* 순번 */
	private Integer seq = 0;
	/* 프로세스 관리번호 */
	private String business_code = "";
	/* 업체 코드 */
	private String bizcd = "";
	/* 업체 이름 */
	private String biznm = "";
	/* 판매 기관 명 */
	private String instt_name = "";
	/* 견적 가격 */
	private int price = 0;
	/* 할인율 */
	private int discount = 0;
	/* 판매수량 */
	private int sale_qy = 0;
	/* 제목 */
	private String contract = "";
	/* 제목 기간*/
	private String contract_period = "";
	/* 계약 시작 일시 */
	private Date contract_period_fr;
	/* 계약 종료 일시 */
	private Date contract_period_to;
	/* 총금액 */
	private int contract_amount = 0;
	/* 계약 일시 */
	private String contract_date;
	/* 수요자 상호 */
	private String demand_name = "";
	/* 수요자 주소 */
	private String demand_addr = "";
	/* 수요자 사업자번호 */
	private String demand_bizno = "";
	/* 수요자 대표이사명 */
	private String demand_cxfc = "";
	/* 공급자 상호 */
	private String supply_name = "";
	/* 공급자 주소 */
	private String supply_addr = "";
	/* 공급자 사업자번호 */
	private String supply_bizno = "";
	/* 공급자 대표이사명 */
	private String supply_cxfc = "";
	/* 기관분류 */
	private String instt_section = "";
	/* 제품 분류 */
	private String product_section = "";
	/* 제품명 */
	private String product_name = "";
	/* 납품 일시 */
	private String offer_date;
	/* 계약 상세 */
	private String contract_cnd = "";
	/* 특약사항 */
	private String special_contract = "";
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
	/* 요청 여부 1: 승인 0: 미승인 */
	private int request = 0;
	/* 승인 일시 */
	private Date consent_date;
	/* 삭제 여부 1: 삭제 0: 활성 */
	private int delete_at = 0;
	/*계약파일명*/
	private String filerealname = "";
	/* 판매 계획명 */
	private String subject = "";
	/*판매계획 시퀀스*/
	private Integer pseq = 0;
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
