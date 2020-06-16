package com.de.main.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.de.cmmn.CmmnMap;
import com.de.cmmn.service.CmmnService;
import com.de.login.service.SecurityMember;

@Controller
@RequestMapping("/main")
public class MainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CmmnService cmmnService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap model, @AuthenticationPrincipal SecurityMember user) throws Exception {
		
		CmmnMap param = new CmmnMap();
		param.put("bizcd",user.getBizcd());
		//사용자 세션의 회사롤
		if("2".equals(user.getBiz_auth_role()))
			param.put("biz_auth_role","총판사");
		else if("3".equals(user.getBiz_auth_role()))
			param.put("biz_auth_role","파트너사");
		
		model.addAttribute("notice", cmmnService.selectList("noticeList", param));
		model.addAttribute("estimate", cmmnService.selectList("estimategetList", param));
		model.addAttribute("saleplan", cmmnService.selectList("saleplangetList", param));
		model.addAttribute("contract", cmmnService.selectList("contractgetList", param));
		model.addAttribute("delivery", cmmnService.selectList("deliverygetList", param));

		return "main/index";
	}


}
