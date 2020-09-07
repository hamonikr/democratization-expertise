package com.de.wiki;

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
@Table(name = "tb_help")
public class help {
	/* 고유 번호 */
	@Id
	@Column
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer seq;
	/* 제목 */
	private String title;
	/* 내용 */
	private String subject;
	/* 구분 = {q: 질문내용 , a: 답변내용} */
	private String type;


}
