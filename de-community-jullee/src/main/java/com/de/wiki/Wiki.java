package com.de.wiki;

import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Wiki{
	

	private Integer wikino;
	/* 회원 고유 번호 */
	private Integer userno;
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
