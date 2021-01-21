package com.de.restapi;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.de.answer.Answers;
import com.de.answer.AnswersService;
import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.file.FileService;
import com.de.file.FileUtil;
import com.de.file.FileVO;
import com.de.login.mapper.LoginMapper;
import com.de.login.service.LoginService;
import com.de.login.service.SecurityMember;
import com.de.login.vo.LoginVO;
import com.de.question.Questions;
import com.de.question.QuestionsService;
import com.de.vote.Vote;
import com.de.vote.VoteService;
import com.de.wiki.Wiki;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
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

	@Autowired
	CmmnService cs;

	@Autowired
	VoteService vs;

	@Autowired
	private RestLicenseChkService restLicenseChkService;

	@Autowired
	private FileUtil fileUtil;

	@Autowired
	private FileService fileService;
	
	@RequestMapping("/feedback")
	public String jsd() {
		System.out.println("jsd=======================");
		return "/jsd/feedback";

	}


	@RequestMapping("/questWrite")
	@ResponseBody
	public ResponseEntity qestWrite(Questions vo, Vote vvo, LoginVO lvo) throws Exception {
		String output = "";
		CmmnMap param = new CmmnMap();

		LoginVO retVO = loginMapper.getUserUUIDInfo(lvo);
		vo.setQuestionno(Integer.parseInt(cs.selectObject("selectQNO", param).getString("questionno")));
		vvo.setPno(vo.getQuestionno());
		vvo.setSection(vo.getSection());
		vvo.setUserno(retVO.getUserno());

		try {
			// 질문등록
			qs.save(vo);
			// 투표등록
			vs.save(vvo);

			param.put("userno", retVO.getUserno());
			param.put("score", 5);
			// 점수등록
			int ret = cs.updateObject("saveScore", param);
			System.out.println("ret===" + ret);
			output = "Y";
		} catch (Exception e) {
			// TODO: handle exception
			output = "N";
		}

		return ResponseEntity.ok(output);
	}


	@RequestMapping("/loginWithoutForm/{uuid}")
	public String loginWithoutForm(@PathVariable(value = "uuid") String uuid, HttpSession session,
			HttpServletResponse response) {
		List<GrantedAuthority> roles = new ArrayList<>(1);
		String roleStr = "ROLE_USER";
		roles.add(new SimpleGrantedAuthority(roleStr));

		String userNo = "";
		LoginVO retVO = new LoginVO();
		try {
			retVO.setUuiduser(uuid);
			retVO = loginMapper.getUserChk(retVO);
			session.setAttribute("userSession", retVO);
			userNo = Integer.toString(retVO.getUserno());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/enterprises/activity/" + userNo;
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

		jsonObject.put("paginationInfo", paginationInfo.getCurrentPageNo());
		jsonObject.put("vo", param);
		jsonObject.put("listCount", listCount);

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
		return ResponseEntity.ok(output);

	}


	@RequestMapping("/view")
	@ResponseBody
	public ResponseEntity view(Questions questions) throws Exception {


		String output = "";
		JSONObject jsonObject = new JSONObject();

		List<Wiki> tagList = qs.findAllTag();
		List<Answers> answerList = as.findAllByquestionno(questions.getQuestionno());

		// 조회수 증가
		qs.updateReanCnt(questions.getQuestionno());
		Questions qvo = new Questions();
		qvo = qs.getView(questions.getQuestionno());

		JSONArray dataArray = new JSONArray();
		JSONObject inData = new JSONObject();
//
		jsonObject.put("questionno", qvo.getQuestionno());
		jsonObject.put("title", qvo.getTitle());
//		inData.put("aswerno", qvo.getAnswers().getAnswerno());
		jsonObject.put("contents", qvo.getContents());
		jsonObject.put("userno", qvo.getUsers().getUsername());
		jsonObject.put("regdt", qvo.getRegisterdate().toString());


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
//				if (retVO.getRepresentat() == 1) {
				Questions ansComplete = qs.getAnswerComplete();
				jsonObject.put("totalCnt", ansComplete.getQuestiontotalcnt());
				jsonObject.put("ansComplete", ansComplete.getAnswercompletecnt());
//				}
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


	@RequestMapping("/getUserInfo")
	@ResponseBody
	public ResponseEntity getUserInfo(LoginVO vo) {

		String output = "";
		JSONObject jsonObject = new JSONObject();
		try {
			LoginVO retVO = loginMapper.getUserUUIDInfo(vo);
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

		int val = 0;
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

		output = jsonObject.toJSONString();

		return ResponseEntity.ok(output);

	}


	@RequestMapping("/getCompQuestion")
	@ResponseBody
	public ResponseEntity getCompQuestion(LoginVO vo) {

		String output = "";
		int val = 0;
		try {
			List<Questions> listData = qs.getCompQuestionList(vo.getUuiduser());
			val = qs.getCompQuestionListCount(vo.getUuiduser());
			if (val > 0) {

				JSONObject jsonObject = new JSONObject();

				JSONArray dataArray = new JSONArray();
				jsonObject.put("newQuestion", "Y");
				output = Integer.toString(val);
				return ResponseEntity.ok(output);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ResponseEntity.ok("N");
		}
		return ResponseEntity.ok(output);
	}

	

	@RequestMapping(value = "/social")
	public String social(Model model, @ModelAttribute(value="socialDataMap") JSONObject jsonObject  ) {
		
		String output = "";
		
		
		output = jsonObject.toJSONString();
		model.addAttribute("output", output);
		
		return "/login/restSocial";
		
		
	}

	

	@ResponseBody
	@RequestMapping("/saveTchnlgyIngry")
	public Map<String, Object> save(HttpServletRequest request, Questions vo, Vote vvo, LoginVO lvo, ModelMap model,
			@RequestParam Map<String, Object> params) throws Exception {

		CmmnMap param = new CmmnMap();
		LoginVO retVO = loginMapper.getUserUUIDInfo(lvo);
		vo.setQuestionno(Integer.parseInt(cs.selectObject("selectQNO", param).getString("questionno")));
		vvo.setPno(vo.getQuestionno());
		vvo.setSection(vo.getSection());
		vvo.setUserno(retVO.getUserno());
			
			
			
		Map<String, Object> dataMap = new HashMap<String, Object>();

		List<MultipartFile> uploadFileList = new ArrayList<MultipartFile>();
		Map<String, List<MultipartFile>> uploadFile = new HashMap<String, List<MultipartFile>>();
		List<FileVO> fileList = null;

		MultipartRequest multipartReq = (MultipartRequest) request;
		Iterator<String> filenames = multipartReq.getFileNames();
		while (filenames.hasNext()) {
			String key = filenames.next();
			uploadFile.put(key, multipartReq.getFiles(key));
			uploadFileList.addAll(multipartReq.getFiles(key));
		}


		if (uploadFileList != null && uploadFileList.size() > 0) {
			fileList = fileUtil.saveAllFiles(uploadFile);
		}

		
		try {
			// 질문등록
			Questions retQuestionVo = qs.save(vo);
			// 투표등록
			vs.save(vvo);

			param.put("userno", retVO.getUserno());
			param.put("score", 5);
			// 점수등록
			int ret = cs.updateObject("saveScore", param);
			
			// file save

			// 첨부파일 관련
			params.put("seq", retQuestionVo.getQuestionno() );
			params.put("section", "Q");

			
			int retFile =  fileService.saveFile(params, fileList);
			if (retFile > 0) {
				dataMap.put("message", "Y");
			}else {
				dataMap.put("message", "N");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return dataMap;
	}
	
}
