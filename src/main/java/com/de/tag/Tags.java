package com.de.tag;

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
@Table(name = "tb_tags")
public class Tags {
	
	/* 태그 고유 번호 */
	private Integer tagNo;
	/* 태그 이름 */
	private String title;
	/* 회원 고유 번호 */
	private String userNo;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updateDate;

}
