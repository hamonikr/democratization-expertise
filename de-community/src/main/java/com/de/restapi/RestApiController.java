package com.de.restapi;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.de.answer.Answers;
import com.de.answer.AnswersService;
import com.de.cmmn.CmmnMap;
import com.de.login.mapper.LoginMapper;
import com.de.login.service.LoginService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.question.Questions;
import com.de.question.QuestionsService;
import com.de.wiki.Wiki;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@RestController
@RequestMapping("/api")
public class RestApiController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	LoginService service;

	@Autowired
	LoginMapper loginMapper;

	@Autowired
	QuestionsService qs;

	@Autowired
	AnswersService as;

	@RequestMapping("/feedback")
	public String jsd() {
		System.out.println("jsd=======================");
		return "/jsd/feedback";

	}


	@ResponseBody
	@RequestMapping(value = "/connt")
	public Map<String, Object> connt(Model model, @RequestParam Map<String, Object> params) {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("gugun", "Y");
		return dataMap;
	}


	@RequestMapping("/get")
	@ResponseBody
	public ResponseEntity getHome(@RequestParam("name") String name, @RequestParam("age") String age) {
//		 RestapiVO apivo = new RestapiVO();
//		 apivo.setMessage("ok");
		return ResponseEntity.ok("Y");
	}


	@RequestMapping(value = "/list")
	@ResponseBody
	public ResponseEntity getList(@RequestParam Map<String, String> params, Questions questions,
			@AuthenticationPrincipal SecurityMember user, @PageableDefault Pageable pageable) throws Exception {
		String output = "";
		JSONObject jsonObject = new JSONObject();

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(100); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		questions.setFirstRecordIndex(firstRecordIndex);
		questions.setRecordCountPerPage(recordCountPerPage);

		List<Questions> listData = qs.getList(questions);
		// List<Tags> tagList = qs.tagList();
		List<Wiki> tagList = qs.findAllTag();

		int listCount = qs.getListCount(questions);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수

//			jsonObject.put("tagList", tagList);
		jsonObject.put("paginationInfo", paginationInfo.getCurrentPageNo());
		jsonObject.put("vo", param);
		jsonObject.put("listCount", listCount);

//		listData.forEach(System.out::println);
		JSONArray dataArray = new JSONArray();
		if (listData != null) {
			for (int i = 0; i < listData.size(); i++) {
				JSONObject inData = new JSONObject();
				inData.put("questionno", listData.get(i).getQuestionno());
				inData.put("title", listData.get(i).getTitle());
				inData.put("contents", listData.get(i).getContents());
				inData.put("userno", listData.get(i).getUsers().getUsername());
				inData.put("regdt", listData.get(i).getRegisterdate().toString());
				dataArray.add(inData);
			}

		}
		jsonObject.put("list", dataArray);

		output = jsonObject.toJSONString();
		System.out.println("output===+" + output);
//		return output;
		return ResponseEntity.ok(output);

	}


	@RequestMapping("/view")
	@ResponseBody
	public ResponseEntity view(Questions questions) throws Exception {

		System.out.println("==========================+" + questions.getQuestionno());

		String output = "";
		JSONObject jsonObject = new JSONObject();

		List<Wiki> tagList = qs.findAllTag();
		List<Answers> answerList = as.findAllByquestionno(questions.getQuestionno());
//		model.addAttribute("tagList", tagList);
//		model.addAttribute("answerList", answerList);
		for (int i = 0; i < answerList.size(); i++) {
			System.out.println("answerList=====" + answerList.get(i));
		}

		// 조회수 증가
		qs.updateReanCnt(questions.getQuestionno());
		Questions qvo = new Questions();
		qvo = qs.getView(questions.getQuestionno());

		JSONArray dataArray = new JSONArray();
//		if (qvo != null) {
//			for (int i = 0; i < qvo.size(); i++) {
		JSONObject inData = new JSONObject();
//
		jsonObject.put("questionno", qvo.getQuestionno());
		jsonObject.put("title", qvo.getTitle());
//		inData.put("aswerno", qvo.getAnswers().getAnswerno());
		jsonObject.put("contents", qvo.getContents());
		jsonObject.put("userno", qvo.getUsers().getUsername());
		jsonObject.put("regdt", qvo.getRegisterdate().toString());
//		dataArray.add(inData);
//			}
//
//		}

//		jsonObject.put("result", dataArray);

		output = jsonObject.toJSONString();

		return ResponseEntity.ok(jsonObject);
	}


	@RequestMapping("/getUserCheck")
	@ResponseBody
	public ResponseEntity getUserCheck(LoginVO vo) {

		String output = "";
		JSONObject jsonObject = new JSONObject();
		try {
			LoginVO retVO = loginMapper.getUserChk(vo);
			if (retVO != null) {
				jsonObject.put("output", "Y");
				jsonObject.put("userid", retVO.getUserid());
				jsonObject.put("usernm", retVO.getUsername());
			} else {
				jsonObject.put("output", "N");
			}
		} catch (Exception e) {
			jsonObject.put("output", "N");
			e.printStackTrace();

		}
		output = jsonObject.toJSONString();
		return ResponseEntity.ok(output);
	}


	@RequestMapping("/userUUID")
	@ResponseBody
	public ResponseEntity userUUID(LoginVO vo) {
//		 RestapiVO apivo = new RestapiVO();
//		 apivo.setMessage("ok");

		int val = 0;
		System.out.println("userUUIDvo===" + vo.toString());
		try {
			val = loginMapper.updateUserUUID(vo);
			if (val > 0) {
				return ResponseEntity.ok("Y");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ResponseEntity.ok("N");
		}
		return ResponseEntity.ok("Y");
	}


	@RequestMapping(value = "/signproc", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ResponseEntity signproc(LoginVO vo, @AuthenticationPrincipal SecurityMember user) {
		String output = "";
		JSONObject jsonObject = new JSONObject();

		try {
			String userPw = vo.getUserpassword();
			vo = service.getUserInfo(vo.getUserid());

			// 비밀번호 재인코딩
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//			System.out.println("==================++++" + passwordEncoder.encode("exitem0*"));

			if (!passwordEncoder.matches(userPw, vo.getUserpassword())) {
				jsonObject.put("output", "N");
			} else {
				jsonObject.put("output", "Y");
				jsonObject.put("userid", vo.getUserid());
				jsonObject.put("usernm", vo.getUsername());
				jsonObject.put("comylocation", vo.getComylocation());
				jsonObject.put("seq", vo.getSeq());
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		System.out.println("sign val -- " + vo.toString());

		output = jsonObject.toJSONString();

//		return output;
		return ResponseEntity.ok(output);

	}


	@RequestMapping("/signproct")
	@ResponseBody
	public ResponseEntity chtttk(HttpServletRequest request, ModelMap model, LoginVO vo) throws Exception {

		String output = "";

		JSONObject jsonObject = new JSONObject();
		System.out.println("vo --- " + vo.toString());
		System.out.println("d----user.getUserid()" + vo.getUserid());

//		vo = service.getUserInfo(vo.getUserid());
//		System.out.println("sign val -- " + vo.toString());

//		loginMapper.updateUserUUID(vo);

//		if (retVo != null) {
//			System.out.println("retVo==" + retVo.toString());
//
//			String strToday = dateFormat.format(c1.getTime());
//			toDate = dateFormat.parse(strToday);
//			edDate = dateFormat.parse(retVo.getLcns_dt());
//
//			System.out.println("Today=" + strToday);
//			System.out.println("2======+" + edDate);
//
//			int compare = toDate.compareTo(edDate);
//
//			if (compare > 0) {
//				// 사용기간 N
//				System.out.println("사용기간 N ::day1 > day2");
//				jsonObject.put("output", "N");
//			} else if (compare < 0) {
//				// 사용기간 Y
//				System.out.println("사용기간 Y === day1 < day2");
//				jsonObject.put("output", "Y");
//				jsonObject.put("stDate", retVo.getLcns_st());
//				jsonObject.put("dtDate", retVo.getLcns_dt());
//			}
//		} else {
//			System.out.println("null ");
//			jsonObject.put("output", "N");
//		}

		jsonObject.put("output", "Y");
		output = jsonObject.toJSONString();

		model.addAttribute("enVal", output);

//		return output;
		return ResponseEntity.ok(output);
	}

}
