package com.hamonize.restApi.technicalsts.service.mapper;


import com.hamonize.restApi.technicalsts.service.vo.RestLicenseChkVO;


public interface RestLicenseChkMapper {

	public RestLicenseChkVO getLcnsChk(RestLicenseChkVO vo);

	public RestLicenseChkVO getView(RestLicenseChkVO vo);

	public int setSave(RestLicenseChkVO vo) throws Exception;

	// ========================================
}
