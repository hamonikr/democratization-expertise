package com.de.restapi;


import java.util.List;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.restapi.mapper.RestLicenseChkMapper;




@Service
public class RestLicenseChkService {

	@Autowired
	RestLicenseChkMapper restLicenseChkMapper;

	/** 라이선스 체크 및 등록 **/

	public RestLicenseChkVO getLcnsChk(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getLcnsChk(vo);
	}


	public RestLicenseChkVO getView(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getView(vo);
	}
	
	public RestLicenseChkVO getDupLicenseChk(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getDupLicense(vo);
	}


	public int setSave(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.setSave(vo);
	}

	// ========================================


	/** 기술문의 **/
	public int selectTchnlgyIngrySEQ() throws Exception {
		return restLicenseChkMapper.selectTchnlgyIngrySEQ();
	}


	public int saveTchnlgyIngrySave(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.saveTchnlgyIngrySave(vo);
	}
	
	public List<RestLicenseChkVO> getTchnlgyCnt(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getTchnlgyCnt(vo);
	}


	public List<RestLicenseChkVO> getTchnlgyData(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getTchnlgyData(vo);
	}


	// ========================================
	/** 공지사항 **/
	public List<RestLicenseChkVO> getNoticeData() throws Exception {
		return restLicenseChkMapper.getNoticeData();
	}


	// ========================================
	/** 만족도 **/
	public int saveSurvey(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.saveSurvey(vo);
	}

}
