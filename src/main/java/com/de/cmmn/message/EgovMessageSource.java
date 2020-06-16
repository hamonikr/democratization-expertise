package com.de.cmmn.message;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

/**
 * 메시지 리소스 사용을 위한 MessageSource 인터페이스 및 ReloadableResourceBundleMessageSource 클래스의 구현체
 * @author 김승원
 * @since 2020.03.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 * 2020.03.20   김승원          최초 생성
 *
 * </pre>
 */
@Configuration
public class EgovMessageSource extends ReloadableResourceBundleMessageSource implements MessageSource {

	private ReloadableResourceBundleMessageSource reloadableResourceBundleMessageSource;

	/**
	 * getReloadableResourceBundleMessageSource() 
	 * @param reloadableResourceBundleMessageSource - resource MessageSource
	 * @return ReloadableResourceBundleMessageSource
	 */	

	public void setReloadableResourceBundleMessageSource(ReloadableResourceBundleMessageSource reloadableResourceBundleMessageSource) {
		this.reloadableResourceBundleMessageSource = reloadableResourceBundleMessageSource;
	}
	
	/**
	 * getReloadableResourceBundleMessageSource() 
	 * @return ReloadableResourceBundleMessageSource
	 */

	public ReloadableResourceBundleMessageSource getReloadableResourceBundleMessageSource() {
		return reloadableResourceBundleMessageSource;
	}
	
	/**
	 * 정의된 메세지 조회
	 * @param code - 메세지 코드
	 * @return String
	 */	
	public String getMessage(String code) {
		return getReloadableResourceBundleMessageSource().getMessage(code, null, Locale.getDefault());
	}
	
	public String getMessage(String code, Object[] obj) {
		return getReloadableResourceBundleMessageSource().getMessage(code, obj, Locale.getDefault());
	}
	
//	public String getMessage(String code, String site_id) {
//		return getReloadableResourceBundleMessageSource().getMessage(code, null, Globals.ENG_ID.equals(site_id)?Locale.US:Locale.getDefault());
//	}
//	
//	public String getMessage(String code, Object[] obj, String site_id) {
//		return getReloadableResourceBundleMessageSource().getMessage(code, obj, Globals.ENG_ID.equals(site_id)?Locale.US:Locale.getDefault());
//	}

}
