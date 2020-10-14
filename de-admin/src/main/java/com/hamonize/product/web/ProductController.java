package com.hamonize.product.web;


import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.hamonize.cmmn.CmmnMap;
import com.hamonize.cmmn.service.CmmnService;
import com.hamonize.login.service.SecurityMember;
import com.hamonize.product.service.ProductService;
import com.hamonize.product.service.ProductVO;
import com.hamonize.sample.service.SampleVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping("/product")
public class ProductController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// @Resource(name = "productService")
	@Autowired
	private ProductService productService;

	@Autowired
	private CmmnService cmmnService;

	@Autowired
	private MessageSource messageSource;
	

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param SampleVO - 조회할 정보가 담긴 ProductVO
	 * @param model
	 * @return "ProductList"
	 * @exception Exception
	 */

	@RequestMapping("/productList")
	public String sampleList(@RequestParam Map<String, String> params, HttpServletRequest request, ProductVO vo,
			ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {

		/**
		 * How to use session info geter
		 * @AuthenticationPrincipal SecurityMember user System.out.println("user=========" + user.getBizcd());
		 */

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		logger.info("----------excel param-----------------------");
		logger.debug("");
		logger.debug(param.toString());
		logger.debug("");
		logger.debug("----------excel param-----------------------");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(5); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		vo.setFirstRecordIndex(firstRecordIndex);
		vo.setRecordCountPerPage(recordCountPerPage);

		List<ProductVO> list = productService.getList(vo);
		int listCount = productService.getListCount(vo);
		paginationInfo.setTotalRecordCount(listCount); // 전체 게시물 건 수
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);

		return "product/list";
	}


	/**
	 * 글을 등록한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */

	@RequestMapping("/productSave")
	public String sampleSave(HttpServletRequest request, ProductVO vo, ModelMap model) throws Exception {
		CmmnMap param = new CmmnMap();
		param.put("code_id", "product_section");
		if (vo.getSeq() != null) {
			//samplevo = productService.getView(samplevo);
			model.addAttribute("result", vo);
		}
		model.addAttribute("codeList", cmmnService.selectList("getProductCode", param));
		return "product/save";
	}


	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void upload(MultipartRequest request) {
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


	/**
	 * 글을 등록한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/save")
	public String save(HttpServletRequest request, ProductVO vo, ModelMap model) throws Exception {

		System.out.println("request====" + request.getParameter("user_name"));
		MultipartRequest multipartReq = (MultipartRequest) request;
		Iterator<String> filenames = multipartReq.getFileNames();
		System.out.println("multipartReq====" + multipartReq.getFileNames());
		MultipartFile multipartFile = null;
		while (filenames.hasNext()) {
			multipartFile = multipartReq.getFile(filenames.next());
			System.out.println("multipartFile====" + multipartFile.getName());
			System.out.println("multipartFile====" + multipartFile.getOriginalFilename());

		}
		int result = productService.save(vo);

		if (result > 0) {
			model.addAttribute("message", messageSource.getMessage("common.insert.success", null, Locale.getDefault()));
			model.addAttribute("url", "sampleList");

		} else {
			model.addAttribute("message", messageSource.getMessage("common.insert.fail", null, Locale.getDefault()));
			model.addAttribute("url", "sampleView?seq=" + vo.getSeq());
		}
		// return "redirect:sampleList?pageNo=1";
		return "cmmn/message";
	}


	/**
	 * 글을 수정한다.
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleSave"
	 * @exception Exception
	 */
	@RequestMapping("/update")
	public String update(HttpServletRequest request, ProductVO vo, ModelMap model) throws Exception {
		System.out.println("update");
		System.out.println("Seq====" + vo.getSeq());
		int result = productService.update(vo);

//		if(result>0){
//			model.addAttribute("message",egovMessageSource.getMessage("성공"));
//			model.addAttribute("url", "sampleList");
//			
//		}else{
//			model.addAttribute("message",egovMessageSource.getMessage("실패"));
//			model.addAttribute("url", "sampleView?seq="+samplevo.getSeq());
//		}
		return "redirect:productList?pageNo=1";

	}


	/**
	 * 상세화면
	 * @param SampleVO - 등록할 정보가 담긴 SampleVO
	 * @param model
	 * @return "sampleView"
	 * @exception Exception
	 */
	@RequestMapping("/productView")
	public String sampleView(HttpServletRequest request, ProductVO vo, ModelMap model) throws Exception {
		vo = productService.getView(vo);
		model.addAttribute("result", vo);
		return "product/view";

	}

}
