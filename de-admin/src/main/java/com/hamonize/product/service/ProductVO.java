package com.hamonize.product.service;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class ProductVO {

	/* 순번 */
	private Integer seq = 0;
	/* 제품 구분 */
	private String product_sn = "";
	/* 제목 */
	private String subject = "";
	/* 제품 가격 */
	private Integer consumer_price = 0;
	/* 이미지 가로 */
	private Integer img_width = 0;
	/* 이미지 세로 */
	private Integer img_vertical = 0;
	/* 내용 */
	private String content = "";
	/* 등록자 ID*/
	private String writer_id = "";
	/* 등록자 이름*/
	private String writer_name = "";
	/* 등록 일시 */
	private Date register_date;
	/* 수정 일시 */
	private Date user_addr;
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
