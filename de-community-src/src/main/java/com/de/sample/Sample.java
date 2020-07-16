package com.de.sample;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "tb_sample")
public class Sample {
	
	/* 순번 */
	@Id
	@Column
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Integer seq = 0;
	/* 게시물 제목 */
	private String title = "";
	/* 게시물 내용 */
	private String contents = "";
	/* 등록자 아이디 */
	private String userId = "";
	/* 등록자 이름 */
	private String userName = "";
	/* 등록자 아이피 */
	private String userIp = "";
	/* 삭제여부 1-삭제 0-활성*/
	private Integer deleteAt = 0;
	/* 조회수 */
	private Integer hit = 0;
	/* 등록 일시 */
	@CreationTimestamp
	@Column(name = "register_date")
	private Timestamp registerDate;
	/* 수정 일시 */
	@UpdateTimestamp
	@Column(name = "update_date")
	private Timestamp updateDate;
	
	public Sample() {}
	
	@Builder
	public Sample(String title,String contents,String userId,String userName,String userIp) {
		this.title = title;
		this.contents = contents;
		this.userId = userId;
		this.userName = userName;
		this.userIp = userIp;
		
	}

}
