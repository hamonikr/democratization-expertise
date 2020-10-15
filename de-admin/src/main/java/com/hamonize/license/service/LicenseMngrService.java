package com.hamonize.license.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamonize.license.service.mapper.LicenseMngrMapper;
import com.hamonize.license.service.vo.LicenseBizVO;
import com.hamonize.license.service.vo.LicenseVO;
import com.weilerhaus.productKeys.ProductKeyGenerator;
import com.weilerhaus.productKeys.enums.ProductKeyState;
import com.weilerhaus.productKeys.impl.BasicProductKeyGenerator;
import com.weilerhaus.productKeys.impl.beans.BasicProductKeyEncodingData;


@Service
public class LicenseMngrService {

	@Autowired
	LicenseMngrMapper lcnsMapper;

	/**
	 * 라이선스 목
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<LicenseBizVO> getList(LicenseBizVO vo) throws Exception {
		return lcnsMapper.getList(vo);
	}


	public int getListCount(LicenseBizVO vo) throws Exception {
		return lcnsMapper.getListCount(vo);
	}

	// =============================================


	/**
	 * 라이선스 상세화면
	 * @param vo
	 * @return
	 */
	public List<LicenseVO> getListLcns(LicenseVO vo) {
		return lcnsMapper.getListLcns(vo);
	}


	public int getListLcnsCount(LicenseVO vo) throws Exception {
		return lcnsMapper.getListLcnsCount(vo);
	}


	public LicenseBizVO getView(LicenseBizVO vo) {
		return lcnsMapper.getView(vo);
	}

	// =============================================


	/**
	 * 라이선스 등록 proc
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int lnscSave(LicenseBizVO vo) throws Exception {

		String retVal = "";

		// 사업자 번호
		//vo.setBizno(vo.getBizno1() + vo.getBizno2() + "-" + vo.getBizno3());

		// 기업 코드 ( 상호 영문 3자리 + 사업자번호 3자리 +년월
		SimpleDateFormat date_format = new SimpleDateFormat("yyMM");
		SimpleDateFormat date_format2 = new SimpleDateFormat("HHmmss");
		Calendar time = Calendar.getInstance();
		String dateTemp = date_format.format(time.getTime());
		String timeTemp = date_format2.format(time.getTime());

		//vo.setBizcd(vo.getBiznm_en().substring(0, 3) + vo.getBizno3() + dateTemp);

		// 기업의 라이선스 생성 코드
		//vo.setBiz_license_uuid(vo.getBiznm_en().substring(0, 3) + vo.getBizno3() + timeTemp);
		int retBiz = 0;
		try {
			retBiz = lcnsMapper.lnscBizSave(vo);
			if (retBiz > 0) {

				List<String> generatedProductKeys = keyCreate(vo.getLicense_count());
				// 키 생성 확인
				//System.out.println("license key chk]============================");
				//generatedProductKeys.forEach(System.out::println);
				String lcns_st = vo.getLicense_period().split("-")[0];
				String lcns_dt = vo.getLicense_period().split("-")[1];
				//System.out.println("lcns_st==="+lcns_st);
				//System.out.println("lcns_dt==="+lcns_dt);
				LicenseVO lnscVo = new LicenseVO();
				lnscVo.setUpper_seq(vo.getSeq());
				lnscVo.setBizcd(vo.getBizcd());
				lnscVo.setLicense_cd(vo.getLicense_cd());
				lnscVo.setBizlncsList(generatedProductKeys);
				lnscVo.setLicense_pd_st(lcns_st);
				lnscVo.setLicense_pd_ed(lcns_dt);
				//lnscVo.setLicense_title(vo.getLicense_title());
				//lnscVo.setLicense_count(vo.getLicense_count());

				int lcnsRet = lcnsMapper.lnscSave(lnscVo);
				if (lcnsRet > 0) {
					retVal = "Y";
					retBiz = 1;
				} else {
					retVal = "N";
					retBiz = 0;
					lcnsMapper.lnscBizDel(vo);
				}

			} else {
				retVal = "N";
			}

		} catch (Exception e) {
			System.out.println("exception msg is :" + e.getMessage());
			retVal = "N";
		}
		return retBiz;
	}

	// =============================================


	public List<String> keyCreate(int cnt) {
		String tmpKey;
		ProductKeyState tmpGeneratedKeyState;
		final List<String> generatedProductKeys = new ArrayList<String>();

		ProductKeyGenerator<BasicProductKeyEncodingData> productKeyGenerator = new BasicProductKeyGenerator(
				new BasicProductKeyEncodingData((byte) 24, (byte) 3, (byte) 101),
				new BasicProductKeyEncodingData((byte) 10, (byte) 4, (byte) 56),
				new BasicProductKeyEncodingData((byte) 1, (byte) 2, (byte) 91),
				new BasicProductKeyEncodingData((byte) 7, (byte) 1, (byte) 100),
				new BasicProductKeyEncodingData((byte) 2, (byte) 36, (byte) 45),
				new BasicProductKeyEncodingData((byte) 13, (byte) 5, (byte) 54),
				new BasicProductKeyEncodingData((byte) 21, (byte) 67, (byte) 25),
				new BasicProductKeyEncodingData((byte) 3, (byte) 76, (byte) 12),
				new BasicProductKeyEncodingData((byte) 31, (byte) 22, (byte) 34),
				new BasicProductKeyEncodingData((byte) 15, (byte) 72, (byte) 65));

		int tmpTryCount;

		System.out.println("**** BUILDING KEYS ****");

		final Random randomGenerator = new Random(System.nanoTime());

		for (int n = 0; n < cnt; n++) {
			tmpKey = null;
			tmpTryCount = 0;

			while ((tmpKey == null) && (tmpTryCount < 10)) {
				try {
					tmpKey = productKeyGenerator.generateProductKey(randomGenerator.nextLong());
				} catch (Exception e) {

				}

				tmpTryCount++;
			}

			if ((tmpKey != null) && (tmpKey.trim().length() > 0)) {
				tmpGeneratedKeyState = productKeyGenerator.verifyProductKey(tmpKey);

				if (ProductKeyState.KEY_GOOD == tmpGeneratedKeyState) {
					generatedProductKeys.add(tmpKey);

//					System.out.println((n + 1) + ") " + ((n < 9) ? " " : "") + "Product Key (GOOD): " + tmpKey);
				} else {
//					System.out.println((n + 1) + ")  " + ((n < 9) ? " " : "") + "Product Key (BAD): " + tmpKey
//							+ ":  Key State: " + tmpGeneratedKeyState.name());
				}
			} else {
				System.out.println("Failed to generate product keys.");

				break;
			}

		}

		System.out.println();
		System.out.println();
		System.out.println("**** VERIFYING KEYS ****");

		BasicProductKeyGenerator basicProductKeyGenerator = new BasicProductKeyGenerator(
				new BasicProductKeyEncodingData((byte) 24, (byte) 3, (byte) 101), null,
				new BasicProductKeyEncodingData((byte) 1, (byte) 2, (byte) 91),
				new BasicProductKeyEncodingData((byte) 7, (byte) 1, (byte) 100), null, null,
				new BasicProductKeyEncodingData((byte) 21, (byte) 67, (byte) 25), null,
				new BasicProductKeyEncodingData((byte) 31, (byte) 22, (byte) 34), null);

		int keyIndex = 0;

		for (String productKey : generatedProductKeys) {
			if ((productKey != null) && (productKey.trim().length() > 0)) {
				tmpGeneratedKeyState = basicProductKeyGenerator.verifyProductKey(productKey);

				if (ProductKeyState.KEY_GOOD == tmpGeneratedKeyState) {

//					System.out.println(
//							(keyIndex + 1) + ") " + ((keyIndex < 9) ? " " : "") + "Product Key (GOOD): " + productKey);

				} else {

//					System.out.println((keyIndex + 1) + ")  " + ((keyIndex < 9) ? " " : "") + "Product Key (BAD): "
//							+ productKey + ":  Key State: " + tmpGeneratedKeyState.name());

				}

				keyIndex++;
			} else {
				System.out.println("Unable to validate empty product key.");
			}
		}
		return generatedProductKeys;
	}
	
	// 게시물 SEQ
	public int selectSEQ() throws Exception {
		return lcnsMapper.selectSEQ();
	}

}
