package com.de.wiki;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class Help {
	/* 고유 번호 */
	private Integer seq;
	/* 제목 */
	private String title;
	/* 내용 */
	private String subject;
	/* 구분 = {q: 질문내용 , a: 답변내용} */
	private String type;


}
