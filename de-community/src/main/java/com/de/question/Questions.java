package com.de.question;


import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.de.answer.Answers;
import com.de.user.Users;
import com.de.vote.Vote;
import com.de.wiki.Wiki;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_questions")
@org.hibernate.annotations.DynamicUpdate
public class Questions {

	/* 질문 고유 번호 */
	@Id
	@Column
	private Integer questionno;
	/* 질문 수정 권한 1이면 수정가능, 0이면 수정불가 */
	private Integer editauth;
	/* 질문 구분 */
	private String section;
	/* 질문 이름 */
	private String title;
	/* 질문 내용 */
	private String contents;
	/* 회원 고유 번호 */
	private Integer userno;
	/* 최초 등록 회원 고유 번호 */
	private Integer firstuserno;
	/* 태그 고유 번호 */
	private String tagno;
	/* 질문 조회수 */
	private Integer readcnt = 0;
	/* 삭제여부 1-삭제 0-활성 */
	private Integer deleteat = 0;

	private String questiontotalcnt;
	private String answercompletecnt;
	/* 등록 일시 */
	@CreationTimestamp
	@Column(name = "registerdate", updatable = false)
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	@Column(name = "updatedate")
	private Timestamp updatedate;
	// 추후 테이블에서 삭제할 컬럼
	/* 정렬 */
	@Transient
	private Integer sort;
	/* 검색 */
	@Transient
	private String searchtext;
	/* 댓글수 */
	@Transient
	private Integer commentcnt = 0;
	@Transient
	private Integer scores = 0;

	/* 페이징 */
	@Transient
	private int firstRecordIndex;
	@Transient
	private int recordCountPerPage;

	@Transient
	private Vote vote;

	@Transient
	private Users users;

	@Transient
	private Wiki wiki;

	@Transient
	private Answers answers;

}
