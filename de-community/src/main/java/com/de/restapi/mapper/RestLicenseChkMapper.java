package com.de.restapi.mapper;


import java.util.List; 

import com.de.restapi.RestLicenseChkVO; 



public interface RestLicenseChkMapper {

	/** 라이선스 체크 및 등록 **/

	public RestLicenseChkVO getLcnsChk(RestLicenseChkVO vo);

	public RestLicenseChkVO getView(RestLicenseChkVO vo);
	
	public RestLicenseChkVO getDupLicense(RestLicenseChkVO vo);

	public int setSave(RestLicenseChkVO vo) throws Exception;

	// ========================================

	/** 기술문의 **/
	public int selectTchnlgyIngrySEQ() throws Exception;

	public int saveTchnlgyIngrySave(RestLicenseChkVO vo) throws Exception;
	
	public List<RestLicenseChkVO> getTchnlgyCnt(RestLicenseChkVO vo);

	public List<RestLicenseChkVO> getTchnlgyData(RestLicenseChkVO vo);

	/** 공지사항 **/
	public List<RestLicenseChkVO> getNoticeData();

	// ========================================

	/** 만족도 **/
	public int saveSurvey(RestLicenseChkVO vo) throws Exception;

}
