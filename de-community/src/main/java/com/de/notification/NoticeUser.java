package com.de.notification;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeUser {
	private String username;
	private String title;
	private String section;
	private String url;
	private int seq;
	
}