package com.de.user;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum UserRole{
	ADMIN("ROLE_ADMIN"),
	USER("ROLE_USER"),
	CLASS_A("ROLE_CLASS_A"),
	CLASS_B("ROLE_CLASS_B"),
	CLASS_C("ROLE_CLASS_C");
	private String value;


}
