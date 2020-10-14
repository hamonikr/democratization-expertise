package com.hamonize.restApi.technicalsts.web;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.hamonize.cmmn.util.AESCipherUtils;
import com.hamonize.restApi.technicalsts.service.RestLicenseChkService;
import com.hamonize.restApi.technicalsts.service.vo.RestLicenseChkVO;


@Controller
@RequestMapping("/restapi")
public class RestLIcenseChkController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private RestLicenseChkService restLicenseChkService;

	@RequestMapping("/feedback")
	public String jsd() {
		System.out.println("jsd=======================");
		return "/jsd/feedback";

	}


	@RequestMapping("/licenseChk")
	public String chk(HttpServletRequest request, RestLicenseChkVO vo, ModelMap model) throws Exception {

		String output = "";
		Date toDate = null, edDate = null;

		JSONObject jsonObject = new JSONObject();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();

		System.out.println("vo============++" + vo.toString());
		RestLicenseChkVO retVo = restLicenseChkService.getLcnsChk(vo);

		if (retVo != null) {
			System.out.println("retVo==" + retVo.toString());

			String strToday = dateFormat.format(c1.getTime());
			toDate = dateFormat.parse(strToday);
			edDate = dateFormat.parse(retVo.getLcns_dt());

			System.out.println("Today=" + strToday);
			System.out.println("2======+" + edDate);

			int compare = toDate.compareTo(edDate);

			if (compare > 0) {
				// 사용기간 N
				System.out.println("사용기간 N ::day1 > day2");
				jsonObject.put("output", "N");
			} else if (compare < 0) {
				// 사용기간 Y
				System.out.println("사용기간 Y === day1 < day2");
				jsonObject.put("output", "Y");
				jsonObject.put("stDate", retVo.getLcns_st());
				jsonObject.put("dtDate", retVo.getLcns_dt());
			}
		} else {
			System.out.println("null ");
			jsonObject.put("output", "N");
		}

		output = jsonObject.toJSONString();

		model.addAttribute("enVal", output);

		return "/restApi/index";
	}


	@RequestMapping("/licenseAddProc")
	public String licenseAddProc(HttpServletRequest request, RestLicenseChkVO vo, ModelMap model) throws Exception {
		JSONObject jsonObject = new JSONObject();
		String output = "";

		RestLicenseChkVO retVo = restLicenseChkService.getView(vo);

		if (retVo != null) {

			String encodeData = retVo.getBizcd() + retVo.getLicense_cd() + retVo.getLicense_no() + retVo.getLcns_st()
					+ retVo.getLcns_dt();

			String setEncodeVal = AESCipherUtils.encriptBase64(encodeData);
			retVo.setUsedUserLicenseUUID(setEncodeVal);

			int retInsertVal = restLicenseChkService.setSave(retVo);

			jsonObject.put("output", "Y");
			jsonObject.put("lcnsno", setEncodeVal);

		} else {
			System.out.println("null ");
			jsonObject.put("output", "N");
			jsonObject.put("lcnsno", "N");
		}

		output = jsonObject.toJSONString();
		model.addAttribute("enVal", output);

		return "/restApi/index";
	}


	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void upload(MultipartRequest request, @RequestParam(value = "_csrf", required = false) String csrf) {
		System.out.println("csrf===" + csrf);
		MultipartFile file1 = request.getFile("file1");
		System.out.println(file1.getName());
		System.out.println(file1.getOriginalFilename());
		System.out.println(file1.getContentType());
		System.out.println(file1.getSize());
		try {
			File filePath = new File("/tmp");
			if (!filePath.exists()) {
				// 폴더 없는 경우 생성한다
				filePath.mkdir();
			}
			file1.transferTo(new File("/home/ryan/test_upload/" + file1.getOriginalFilename()));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
