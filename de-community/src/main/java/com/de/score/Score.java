package com.de.score;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_score")
public class Score {
	
	/* 순번 */
	@Id
	@Column
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer seq = 0;
	/* 상위 번호 */
	private Integer pno = 0;
	/* 구분 */
	private String section = "";
	/* 유저 번호 */
	private Integer userno = 0;
	/* 점수 */
	private Integer score = 0;

}
