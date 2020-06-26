package com.de.question;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

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
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer questionNo;
	/* 질문 수정 권한 */
	private Integer editAuth;
	/* 질문 구분 */
	private String section;
	/* 질문 이름 */
	private String title;
	/* 질문 내용 */
	private String contents;
	/* 회원 고유 번호 */
	private String userNo;
	/* 태그 고유 번호 */
	private Integer[] tagNo;
	/* 질문 조회수 */
	private Integer readCnt;
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

}
