package com.de.wiki;


import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Embeddable
@Entity
@Table(name = "tb_wiki")
public class Wiki implements Serializable {

	@Id
	@Column(name = "wikino")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer wikino;
	/* 회원 고유 번호 */
	private Integer userno;
	/* 위키 구분 : tags : t, help :t */
	private String section;
	/* 위키 이름 */
	private String title;
	/* 위키 내용 */
	private String contents;
	/* 삭제 여부 = 0:유지, 1:삭제0 */
	private Integer deleteat;
	/* 연관 질문 갯수 */
	private Integer relatedcnt;
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;
	/* 페이징 */
	@Transient
	private int firstRecordIndex;
	@Transient
	private int recordCountPerPage;

}
