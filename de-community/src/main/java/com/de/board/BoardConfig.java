package com.de.board;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
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
@Entity
@Table(name = "tb_boardconfig")
public class BoardConfig {
	
	@Id
	@Column
	/* boardid */
	private String boardid;
	
	private String boardname;
	
	private String boarauth;
	
	private Integer deleteat;
	
	/* 등록 일시 */
	@CreationTimestamp
	@Column(name = "registerdate", updatable = false)
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	@Column(name = "updatedate")
	private Timestamp updatedate;
	
	/* 페이징 */
	@Transient
	private int firstRecordIndex;
	@Transient
	private int recordCountPerPage;

}
