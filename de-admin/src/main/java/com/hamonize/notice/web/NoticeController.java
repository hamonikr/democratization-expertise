package com.hamonize.notice.web;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.estimate.service.EstimateVO;
import com.hamonize.file.FileUtil;
import com.hamonize.file.service.FileService;
import com.hamonize.login.service.SecurityMember;
import com.hamonize.notice.service.NoticeService;
import com.hamonize.notice.service.NoticeVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping("/notice")
public class NoticeController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// @Resource(name = "sampleService")
	@Autowired
	private NoticeService noticeservice;

	@Autowired
	private CmmnService cmmnService;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private FileService fileService;

	@Autowired
	private MessageSource messageSource;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param SampleVO - 조회할 정보가 담긴 SampleVO
	 * @param model
	 * @return "SampleList"
	 * @exception Exception
	 */

	@RequestMapping("/list.ivs")
	public String list(@RequestParam Map<String, String> params, HttpServletRequest request, NoticeVO vo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------param-----------------------");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		vo.setFirstRecordIndex(firstRecordIndex);
		vo.setRecordCountPerPage(recordCountPerPage);
		//사용자 세션의 회사롤
		if("1".equals(user.getBiz_auth_role()))
			vo.setBiz_auth_role("총판사");
		else if("2".equals(user.getBiz_auth_role()))
			vo.setBiz_auth_role("파트너사");

		List<NoticeVO> list = noticeservice.getList(vo);
		int listCount = noticeservice.getListCount(vo);
		System.out.println("size==="+listCount);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("userSession", user);
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "notice/list";
	}

	/**
	 * 상세화면
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleView"
	 * @exception Exception
	 */
	@RequestMapping("/view.ivs")
	public String sampleView(HttpServletRequest request, NoticeVO vo, ModelMap model) throws Exception {
		CmmnMap param = new CmmnMap();
		param.put("seq", vo.getSeq());
		param.put("section","notice");
		vo = noticeservice.getView(vo);
		model.addAttribute("result", vo);
		model.addAttribute("file", cmmnService.selectList("viewFile", param));
		return "notice/view";

	}
	
}
