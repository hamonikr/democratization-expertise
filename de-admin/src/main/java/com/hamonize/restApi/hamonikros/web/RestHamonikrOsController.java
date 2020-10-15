package com.hamonize.restApi.hamonikros.web;


import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hamonize.restApi.hamonikros.service.RestHamonikrOsService;
import com.hamonize.restApi.hamonikros.service.mapper.RestHamonikrOsMapper;
import com.hamonize.restApi.hamonikros.service.vo.RestHamonikrOsVO;


@Controller
@RequestMapping("/restapi")
public class RestHamonikrOsController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private RestHamonikrOsService restHamonikrOsService;

	@Autowired
	private RestHamonikrOsMapper restHamonikrOsMapper;

	@RequestMapping("/base_save")
	public String chk(HttpServletRequest request, RestHamonikrOsVO vo, ModelMap model) throws Exception {

		String output = "";
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();

		StringBuffer json = new StringBuffer();
		String line = null;

		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				json.append(line);
//				System.out.println("line=====+++>" + line);
			}

		} catch (Exception e) {
			System.out.println("Error reading JSON string: " + e.toString());
		}

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(json.toString());
		JSONArray insArray = (JSONArray) jsonObj.get("dpkglist");
		JSONObject object = (JSONObject) insArray.get(0);

		Map<String, Object> insertDataMap = new HashMap<>();

		RestHamonikrOsVO[] inputVo = new RestHamonikrOsVO[insArray.size()];
		for (int i = 0; i < insArray.size(); i++) {
			JSONObject tempObj = (JSONObject) insArray.get(i);
			inputVo[i] = new RestHamonikrOsVO();
			inputVo[i].setName(tempObj.get("name").toString().trim());
			inputVo[i].setVersion(tempObj.get("version").toString().trim());
		}

		System.out.println("inputVo]======================================");
		for (int i = 0; i < inputVo.length; i++) {
			System.out.println("updtVo[i]=======" + inputVo[i].toString());
		}

		insertDataMap.put("list", inputVo);
		restHamonikrOsMapper.insertDpkgInfo(insertDataMap);

		return "/restApi/index";
	}


	@RequestMapping("/updtDpkg")
	public String updtDpkg(HttpServletRequest request, RestHamonikrOsVO vo, ModelMap model) throws Exception {
		System.out.println("===================");
		String output = "";
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();

		StringBuffer json = new StringBuffer();
		String line = null;

		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				json.append(line);
				System.out.println("line=====+++>" + line);
			}

		} catch (Exception e) {
			System.out.println("Error reading JSON string: " + e.toString());
		}

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(json.toString());
		JSONArray insArray = (JSONArray) jsonObj.get("upgradable");
		JSONObject object = (JSONObject) insArray.get(0);

		System.out.println("object=========++" + object.get("name"));

		Map<String, Object> insertDataMap = new HashMap<>();

		RestHamonikrOsVO[] inputVo = new RestHamonikrOsVO[insArray.size()];
		for (int i = 0; i < insArray.size(); i++) {
			JSONObject tempObj = (JSONObject) insArray.get(i);
			inputVo[i] = new RestHamonikrOsVO();
			inputVo[i].setName(tempObj.get("name").toString().trim());
			inputVo[i].setGubun(tempObj.get("gubun").toString().trim());
		}

		System.out.println("inputVo]======================================");
		for (int i = 0; i < inputVo.length; i++) {
			System.out.println("updtVo[i]=======" + inputVo[i].toString());
		}

		restHamonikrOsMapper.delUpgradable();
		insertDataMap.put("list", inputVo);
		restHamonikrOsMapper.insertUpgradableDpkg(insertDataMap);

		return "/restApi/index";
	}

}
