package com.de.answer;

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
@Table(name = "tb_answers")
public class Answers {
	
	/* 답변 고유 번호 */
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer answerNo;
	/* 질문 고유 번호 */
	private String questionNo;
	/* 답변 수정 권한 */
	private Integer editAuth;
	/* 채택 여부 */
	private Integer selected;
	/* 답변 제목 */
	private String title;
	/* 답변 내용 */
	private String contents;
	/* 회원 고유 번호 */
	private String userNo;
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

}
