package com.de.answer;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.Where;

import com.de.user.Users;
import com.de.vote.Vote;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_answers")
@org.hibernate.annotations.DynamicUpdate
public class Answers {
	
	/* 답변 고유 번호 */
	@Id
	@Column
	private Integer answerno;
	/* 질문 고유 번호 */
	private Integer questionno;
	/* 답변 수정 권한 */
//	private Integer editauth;
	/* 채택 여부 */
	private Integer selected;
	/* 답변 내용 */
	private String contents;
	/* 회원 고유 번호 */
	private Integer userno;
	/* 등록 일시 */
	@CreationTimestamp
	@Column(name = "registerdate", updatable = false)
	private Timestamp registerdate;
	/* 수정 일시 */
	@UpdateTimestamp
	private Timestamp updatedate;
	
	@Transient
	private Integer scores = 0;
	
//	@OneToOne
//	@JoinColumn(name= "userno", insertable = false, updatable = false)
	@Transient
	private Users users;
	
	@Transient
	private Vote vote;

}
