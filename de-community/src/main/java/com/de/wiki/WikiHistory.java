package com.de.wiki;

import java.io.Serializable;
import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class WikiHistory {
	
	/* 테이블 고유 번호 */
	private Integer seq;
	/* 위키 고유 번호 */
	private Integer wikino;
	/* 위키 작성/수정 유저 번호 */
	private Integer userno;
	/* 유저이름 */
	private String username;
	/* 위키 구분 : tags, help*/
	private String section;
	/* 위키 이름 */
	private String title;
	/* 위키 내용 */
	private String contents;	
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;

}
