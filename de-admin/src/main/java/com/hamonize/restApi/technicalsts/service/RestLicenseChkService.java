package com.hamonize.restApi.technicalsts.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamonize.restApi.technicalsts.service.mapper.RestLicenseChkMapper;
import com.hamonize.restApi.technicalsts.service.vo.RestLicenseChkVO;


@Service
public class RestLicenseChkService {

	@Autowired
	RestLicenseChkMapper restLicenseChkMapper;

	public RestLicenseChkVO getLcnsChk(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getLcnsChk(vo);
	}


	public RestLicenseChkVO getView(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.getView(vo);
	}


	public int setSave(RestLicenseChkVO vo) throws Exception {
		return restLicenseChkMapper.setSave(vo);
	}

}
