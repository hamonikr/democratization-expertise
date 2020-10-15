package com.hamonize.license.service.mapper;


import java.util.List;

import com.hamonize.license.service.vo.LicenseBizVO;
import com.hamonize.license.service.vo.LicenseVO;


public interface LicenseMngrMapper {

	/**
	 * 라이선스 등록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int lnscBizSave(LicenseBizVO vo) throws Exception;

	public int lnscSave(LicenseVO vo) throws Exception;

	public int lnscBizDel(LicenseBizVO vo) throws Exception;
	
	// 게시물 SEQ
	public int selectSEQ() throws Exception;

	// ========================================

	/**
	 * 라이선스 목록
	 * @param vo
	 * @return
	 */
	public List<LicenseBizVO> getList(LicenseBizVO vo);

	public int getListCount(LicenseBizVO vo) throws Exception;

	// ========================================

	/**
	 * 라이선스 상세 화면
	 * @param vo
	 * @return
	 */
	public List<LicenseVO> getListLcns(LicenseVO vo);

	public int getListLcnsCount(LicenseVO vo) throws Exception;

	public LicenseBizVO getView(LicenseBizVO vo);

	// ========================================
}
