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

import com.de.user.UsersDetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Embeddable
@Table(name = "tb_help")
public class Help implements Serializable{
	
	@Id
	@Column(name="seq")
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	/* 고유 번호 */
	private Integer seq;
	/* 질문 */
	private String question;
	/* 내용 */
	private String answer;
	/* 구분 = {fna:f, etc:e} */
	private String type;
	/* 질문 카테고리 : tag, qna, wiki, users, policy..*/
	private String category;
	
}
