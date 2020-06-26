package com.de.badge;

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
@Table(name = "tb_badge")
public class Badge {
	
	/* 배지 고유 번호 */
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private String badgeNo;
	/* 배지 이름 */
	private String badgeName;
	/* 배지 점수 */
	private String badgeScore;
	

}
