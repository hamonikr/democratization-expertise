package com.de.cmmn.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.LoggerFactory;

import com.de.cmmn.exception.ProjectException;
import com.de.cmmn.message.ContextMessage;

public enum CodeMessage {
	
	// @formatter:off
	// 에러 메시지
	ERROR_000001_시스템_오류_입니다_,
	ERROR_000002_등록된_사용자_정보를_찾을수_없습니다_,
	ERROR_000003_암호화_오류입니다_,
	ERROR_000004_정보가_잘못_입력되었습니다__확인_후_다시_시도해_주세요_,
	ERROR_000005_메일_발송중_오류가_발생하였습니다_,
	ERROR_000006_SMS_발송중_오류가_발생하였습니다_,
	ERROR_000007_주소_검색중_오류가_발생하였습니다_,
	ERROR_000008_엑셀_파싱중_오류가_발생하였습니다_,

//	기본 메시지
	MSG_000011_등록_되었습니다_,
	MSG_000012_수정_되었습니다_,
	MSG_000013_삭제_되었습니다_,
	MSG_000014_변경_되었습니다_,
	MSG_000021_등록_중_오류가_발생하였습니다_,
	MSG_000022_수정_중_오류가_발생하였습니다_,
	MSG_000023_삭제_중_오류가_발생하였습니다_,
	MSG_000024_변경_중_오류가_발생하였습니다_,
	MSG_000031_로그인후_다시_시도해_주세요_,

	// 사용자 100*
	MSG_100001_변경된_정보를_저장하였습니다_,
	MSG_100002_이미_가입된_휴대폰번호입니다_,
	MSG_100003_입력하신_휴대폰번호로_인증번호를_전송하였습니다__3분_이내로_인증해_주세요_,
	MSG_100004_인증번호가_유효하지_않습니다__인증번호를_다시_확인해_주세요_,
	MSG_100005_유효하지_않은_사업자등록번호입니다_,
	MSG_100006_등록된_회원_정보를_찾을_수_없습니다__입력정보를_다시_확인해_주세요_,
	MSG_100007_비밀번호_변경중_오류가_발생하였습니다__다시_확인해주세요_,
	MSG_100008_휴먼계정_입니다_,
	MSG_100009_비밀번호가_일치하지_않습니다__다시_확인해주세요_,
	MSG_100010_회원_정보_변경중_오류가_발생하였습니다__입력정보를_다시_확인해_주세요_,

	// END
	;
	// @formatter:on
	
	private static final String MESSAGE_PATTERN = "^(ERROR|MSG|CODE)_(\\d+)_(.+)$";

	private String code;
	private String type;
	private String hint;
	
	CodeMessage() {
		LoggerFactory.getLogger(CodeMessage.class).debug("[Initialize] MessageCode.{}", name());

		if (!name().matches(MESSAGE_PATTERN)) {
			throw new RuntimeException("Not pattern: " + name());
		}

		Pattern pattern = Pattern.compile(MESSAGE_PATTERN);
		Matcher matcher = pattern.matcher(name());

		matcher.find();

		type = matcher.group(1);
		code = matcher.group(2);
		hint = matcher.group(3);
	}

	public String getCode() {
		return code;
	}

	public String getType() {
		return type;
	}

	public String getHint() {
		return hint;
	}

	public String getMessage() {
		return ContextMessage.getMessage(code);
	}

	public String getMessage(Object... params) {
		return ContextMessage.getMessage(code, params);
	}

	public ProjectException toException() {
		throw new ProjectException(this);
	}

	public RuntimeException toException(Object... params) {
		return new ProjectException(this, params);
	}

	public RuntimeException toException(Throwable cause) {
		return new ProjectException(this, cause);
	}

	public RuntimeException toException(Throwable cause, Object... params) {
		return new ProjectException(this, params, cause);
	}
}