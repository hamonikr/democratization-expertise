
package com.de.cmmn;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.de.cmmn.service.CmmnService;
import com.de.enterprise.EnterpriseService;
import com.de.enterprise.Enterprises;
import com.de.question.QuestionsService;
import com.de.user.Users;
import com.de.user.UsersService;
import com.de.wiki.Wiki;
import com.de.wiki.WikiRepository;
import com.de.wiki.service.WikiService;


@Controller
@RequestMapping(value = "/cmmn")
public class CmmnController {

	@Autowired
	WikiService service;

	@Autowired
	QuestionsService qs;

	@Autowired
	UsersService usersService;

	@Autowired
	CmmnService cs;

	@Autowired
	EnterpriseService es;

	@Autowired
	WikiRepository wr;

	@RequestMapping("/view")
	@ResponseBody
	public Wiki view(HttpServletRequest request, Model model) throws Exception {
		Wiki wiki_view = service.getView(19);
		return wiki_view;
	}


	@RequestMapping(value = "/list")
	@ResponseBody
	public CmmnMap userList(@RequestParam Map<String, String> params, Model model, @PageableDefault Pageable pageable)
			throws Exception {
		Page<Users> list = usersService.findAll(pageable);

		List<Enterprises> plist = es.getPromteList();

		model.addAttribute("partners_list", plist);
		model.addAttribute("paging", list);
		model.addAttribute("data", list.getContent());

		CmmnMap param = new CmmnMap();

		param.put("user", cs.selectList("getUserScore", param));
		param.put("partner", cs.selectList("getPartnerScore", param));
		param.put("partnerslist", cs.selectList("getPromteList", param));
		param.put("board", cs.selectList("boardConfig", param));
		param.put("tag", wr.findAllBySectionAndDeleteat("t", 0));

		return param;
	}

}
