package com.hamonize.notice.service;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class NoticeVO {

	/* 테이블 번호 */
	private Integer seq = 0;
	/* 공지대상 */
//	private List<String> target;//default all
	private String target;//default all
	/* 공지사항 제목 */
	private String title = "";
	/* 공지사항 내용 */
	private String contents = "";
	/* 등록하는 사용자 아이디  - 어드민에서는 관리자 아이디 디폹트..?*/
	private String user_id = "관리자";
	/* 조회수 */	
	private Integer read_count;
	/* 공지사항 중요도 */	
	private Integer importance=0;
	/* 삭제여부 */	
	private Integer delete_at;	
	/* 등록일 */
	private Date reg_date;   
	/* 수정일 */
	private Date updt_date;
	/* 회사 종류 */
	private String biz_auth_role;
	/* 회사이름 */
	private String biznm;
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;

}
