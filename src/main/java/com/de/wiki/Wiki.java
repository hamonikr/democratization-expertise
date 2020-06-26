package com.de.wiki;

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
@Table(name = "tb_wiki")
public class Wiki {
	
	/* 위키 고유 번호 */
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer wikiNo;
	/* 위키 구분 */
	private String section;
	/* 부모 고유 번호 */
	private Integer pNo;
	/* 위키 이름 */
	private String title;
	/* 위키 내용 */
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
