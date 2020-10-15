package com.hamonize.cmmn.exception;


import org.springframework.security.core.userdetails.UserDetails;

import com.hamonize.cmmn.util.CodeMessage;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class SleepedException extends RuntimeException {

	private static final long serialVersionUID = 107829928360443845L;
	private CodeMessage code;
	private UserDetails userDetails;

	public SleepedException(UserDetails userDetails, CodeMessage code) {
		this(userDetails, code, (Object[]) null);
	}


	public SleepedException(UserDetails userDetails, CodeMessage code, Object... params) {
		super(code.getMessage(params), code.toException(params));
		this.code = code;
		this.userDetails = userDetails;
	}

}