package com.de.question;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.de.user.Users;
import com.de.vote.Vote;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_questions")
public class Questions {
	
	/* 질문 고유 번호 */
	@Id
	@Column
	private Integer questionno;
	/* 질문 수정 권한 */
	private Integer editauth;
	/* 질문 구분 */
	private String section;
	/* 질문 이름 */
	private String title;
	/* 질문 내용 */
	private String contents;
	/* 회원 고유 번호 */
	private Integer userno;
	/* 태그 고유 번호 */
	private String tagno;
	/* 질문 조회수 */
	private Integer readcnt = 0;
	/* 삭제여부 1-삭제 0-활성*/
	private Integer deleteat = 0;
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;
	//추후 테이블에서 삭제할 컬럼
	/* 정렬 */
	private Integer sort;
	/* 검색 */
	private String searchtext;
	
	/* 페이징 */
	private int firstRecordIndex;
	private int recordCountPerPage;
	
	@ManyToOne
	@JoinColumn(name= "pno", insertable = false, updatable = false)
	private Vote vote;
	
	@ManyToOne
	@JoinColumn(name= "userno", insertable = false, updatable = false)
	private Users users;

}