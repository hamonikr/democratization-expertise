package com.de.sample;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.de.common.service.CmmnService;

@Controller
@RequestMapping(value = "/sample")
public class SampleController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	SampleService ss;
	
	@Autowired
	CmmnService cs;

	@RequestMapping(value = "/list")
	public String getList(Model model, @PageableDefault Pageable pageable) throws Exception{
		System.out.println("----------sample----------");
		Page<Sample> list = ss.findAll(pageable);
		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");
		model.addAttribute("paging", list);
		model.addAttribute("data", list.getContent());
		return "/sample/list";
	}
	
	@RequestMapping(value = "/list2")
	public String getList2(Model model, @PageableDefault Pageable pageable) throws Exception{
		System.out.println("----------sample2----------");
		List<Sample> list = ss.list(pageable);
		HashMap param = new HashMap();
//		logger.info("총 element 수 : {" + list.getTotalElements() + "}, 전체 page 수 : {" + list.getTotalPages() + "}, "
//				+ "페이지에 표시할 element 수 : {" + list.getSize() + "}, 현재 페이지 index : {" + list.getNumber() + "}, "
//				+ "현재 페이지의 element 수 : {" + list.getNumberOfElements() + "}");
//		model.addAttribute("paging", list);
//		model.addAttribute("data", list);
		model.addAttribute("data", cs.selectList("list", param));
		return "/sample/list";
	}

	@RequestMapping(value = "/save")
	public String save(Model model, Sample vo) throws Exception{

		return "/sample/save";
	}

	@RequestMapping(value = "/save.proc")
	public String saveproc(HttpServletRequest request, Model model, Sample vo) throws Exception{
		vo.setUserIp(request.getRemoteAddr());
		ss.save(vo);
		// model.addAttribute("sample", ss.findById(sample.getSeq()));
		return "redirect:/sample/list";
	}

	@RequestMapping("/view/{seq}")
	public String view(@PathVariable("seq") int seq, Model model) throws Exception{
		Optional<Sample> sample = ss.findById(seq);
		model.addAttribute("result", sample.orElse(null));
		return "/sample/view";
	}

	@RequestMapping("/edit/{seq}")
	public String edit(@PathVariable("seq") int seq, Sample vo, Model model) throws Exception{
		Optional<Sample> sample = ss.findById(seq);
		model.addAttribute("result", sample.orElse(null));
		return "/sample/save";
	}
	
	@RequestMapping(value = "/edit.proc")
	public String editproc(HttpServletRequest request, Model model, Sample vo) throws Exception{
		ss.updateById(vo);
		return "redirect:/sample/list";
	}

}
