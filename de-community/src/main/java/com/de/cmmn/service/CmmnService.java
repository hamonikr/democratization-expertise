package com.de.cmmn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.cmmn.CmmnMap;

import egovframework.rte.fdl.excel.impl.EgovExcelServiceImpl;

/**
 * @author 김승원
 * @since 2020. 03. 19.
 * @version 1.0
 *
 * <pre>
 * Name : CmmnDAO.java
 * Description  : TODO
 * 
 * << 개정이력(Modification Information) >>
 *   
 *   수정일             수정자             수정내용
 * ==============================================
 *  2020. 03. 19.      김승원             최초 생성
 *
 * </pre>
 */
@Service
@Transactional
public class CmmnService extends EgovExcelServiceImpl {
	//@Resource(name="cmmnDAO")
    @Autowired
	private CmmnDAO cmmnDAO;
	
	public List<CmmnMap> selectList(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.selectList(sqlId, param);
	}

	public CmmnMap selectObject(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.selectObject(sqlId, param);
	}
	
	public int selectCount(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.selectCount(sqlId, param);
	}
	
	public String insert(String sqlId, CmmnMap param) throws Exception {
		cmmnDAO.insertObject(sqlId, param);
		return "success";
	}	

	public void insertObject(String sqlId, CmmnMap param) throws Exception {
		cmmnDAO.insertObject(sqlId, param);
	}

	public String insertObjectReturnKeyString(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.insertObjectReturnKeyString(sqlId, param);
	}

	public int updateObject(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.updateObject(sqlId, param);
	}

	public int deleteObject(String sqlId, CmmnMap param) throws Exception {
		return cmmnDAO.deleteObject(sqlId, param);
	}

//	public void insertBatchObject(String sqlId,CmmnMap param,List<CmmnMap> dataList)throws Exception{
//		cmmnDAO.insertBatchObject(sqlId, param, dataList);
//	}
//	
//	public void updateBatchObject(String sqlId,CmmnMap param,List<CmmnMap> dataList)throws Exception{
//		cmmnDAO.updateBatchObject(sqlId, param, dataList);
//	}
//	
//	public void deleteBatchObject(String sqlId,CmmnMap param,List<CmmnMap> dataList)throws Exception{
//		cmmnDAO.deleteBatchObject(sqlId, param, dataList);
//	}
//	
//	public void insertList(String sqlId, List<CmmnMap> dataList) throws Exception{
//		cmmnDAO.insertList(sqlId,dataList);
//	}
//	
//	public int updateForeach(String sqlId,List<CmmnMap>dataList)throws Exception{
//		return cmmnDAO.updateForeach(sqlId,dataList);
//	}
}
