package com.de.wiki;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.de.user.UsersDetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Embeddable
@Table(name = "tb_wiki")
public class Wiki implements Serializable{
	
	/* 위키 고유 번호 */
	@Id
	@Column(name="wikino")
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer wikino;
	/* 회원 고유 번호 */
	private Integer userno;
	/* 위키 구분 : tags, help*/
	private String section;
	/* 위키 이름 */
	private String title;
	/* 위키 내용 */
	private String contents;	
	/* 등록 일시 */
	@CreationTimestamp
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;

}
