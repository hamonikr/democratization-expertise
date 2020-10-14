package com.hamonize.restApi.hamonikros.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamonize.restApi.hamonikros.service.mapper.RestHamonikrOsMapper;
import com.hamonize.restApi.hamonikros.service.vo.RestHamonikrOsVO;


@Service
public class RestHamonikrOsService {

	@Autowired
	RestHamonikrOsMapper restHamonikrOsMapper;

//	public RestHamonikrOsVO getLcnsChk(RestHamonikrOsVO vo) throws Exception {
//		return restHamonikrOsMapper.getLcnsChk(vo);
//	}
//
//
//	public RestHamonikrOsVO getView(RestHamonikrOsVO vo) throws Exception {
//		return restHamonikrOsMapper.getView(vo);
//	}

	public int setSave(RestHamonikrOsVO vo) throws Exception {
		return restHamonikrOsMapper.setSave(vo);
	}

}
