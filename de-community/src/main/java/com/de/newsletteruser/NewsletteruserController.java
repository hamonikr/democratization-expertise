package com.de.newsletteruser;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping(value = "/newsletters")
public class NewsletteruserController {

	@Autowired
	NewsletteruserService service;
	
	@RequestMapping(value = "/subscribe")
	public String subscribeForm(Model model, @PageableDefault Pageable pageable) {
		System.out.println("-----------news letter---------");
	
		return "/newsletter/subscribe";
	}
	
	@ResponseBody
	@RequestMapping(value = "/subscribe.proc", method = RequestMethod.POST)
    public int subscribeProc(HttpServletRequest request, MailingUserList vo, Model model, RedirectAttributes redirectattribute ) throws Exception {
		
		System.out.println("vo--?" + vo.getEmail());	
		System.out.println("vo--?" + vo.getName());


		int chkDup = service.checkDuplication(vo);
		System.out.println("chkDup -- >" +chkDup);
		if(chkDup < 1) {
			vo.setActive(0);// 0이면 구독 1이면 비구독
			int ret = service.saveSubscriber(vo);
	//		return "redirect:/newsletters/subscribe";
			return chkDup;

		} else {
			System.out.println("중복된 이메일");
		//	redirectattribute.addAttribute("chkDup", chkDup);
		//	model.addAttribute("chkDup", chkDup);
			return chkDup;
		}
		
    }
}

