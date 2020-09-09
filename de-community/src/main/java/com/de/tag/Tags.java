package com.de.tag;

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
@Table(name = "tb_tags")
public class Tags {
	
	/* 태그 고유 번호 */
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer tagno;
	/* 태그 이름 */
	private String title;
	/* 회원 고유 번호 */
	private String userno;
	/* 가입 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;

}
