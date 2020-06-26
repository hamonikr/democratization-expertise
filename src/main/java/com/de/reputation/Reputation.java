package com.de.reputation;

import java.sql.Timestamp;

import javax.persistence.Entity;
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
@Table(name = "tb_reputation")
public class Reputation {
	
	/* 평판 고유 번호 */
	private Integer seq;
	/* 부모 고유 번호 */
	private Integer pNo;
	/* 구분 */
	private String section;
	/* 점수*/
	private Integer score;
	/* 회원 고유 번호 */
	private String userNo;
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

}
