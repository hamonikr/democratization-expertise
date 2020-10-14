package com.hamonize.restApi.hamonikros.service.mapper;


import java.util.Map;

import com.hamonize.restApi.hamonikros.service.vo.RestHamonikrOsVO;


public interface RestHamonikrOsMapper {

//	public RestHamonikrOsVO getLcnsChk(RestHamonikrOsVO vo);

//	public RestHamonikrOsVO getView(RestHamonikrOsVO vo);

	public int setSave(RestHamonikrOsVO vo) throws Exception;

	public int insertDpkgInfo(Map<String, Object> map);

	public int insertUpgradableDpkg(Map<String, Object> map);

	public int delUpgradable();

	// ========================================
}
