
package com.de.wiki;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.de.cmmn.CmmnMap;
import com.de.login.vo.LoginVO;
import com.de.question.QuestionsService;
import com.de.wiki.service.WikiService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestMapping(value = "/wiki")
public class WikiController {

	@Autowired
	WikiService service;

	@Autowired
	QuestionsService qs;

	@Autowired
	private MessageSource messageSource;

	@RequestMapping("/getStart")
	public String accountRecovery(HttpServletRequest request, LoginVO user, Wiki vo, Model model,
			HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user != null) {
			System.out.println("user type -->" + user.getRole());
		}

		// fna list
		vo.setSection("h");
		vo.setFirstRecordIndex(0);
		vo.setRecordCountPerPage(10);

		List<Wiki> fna_list = service.getWikiList(vo);
		model.addAttribute("result", fna_list);

		// MENUAL list
		vo.setSection("m");
		List<Wiki> menual_list = service.getWikiList(vo);
		model.addAttribute("menual_result", menual_list);

		// tag
		vo.setSection("t");
		List<Wiki> get_list = service.getWikiList(vo);

		// wiki
		vo.setSection("w");
		List<Wiki> wiki_list = service.getWikiList(vo);
		model.addAttribute("wiki_result", wiki_list);

		int[] tagno_cnt = new int[get_list.size()];
		for (int i = 0; i < get_list.size(); i++) {
			tagno_cnt[i] = service.getWikiCount(get_list.get(i).getWikino());
			get_list.get(i).setRelatedcnt(tagno_cnt[i]);
		}

		model.addAttribute("tagsResult", get_list);

		return "/wiki/start";
	}


	@RequestMapping("/Help/{gubun}")
	public String helplist(@RequestParam Map<String, String> params, @PageableDefault Pageable pageable, Wiki vo,
			Model model, @PathVariable("gubun") String gubun, HttpSession httpSession) throws Exception {

//		vo.setSection("h");

		CmmnMap param = new CmmnMap();
		param.putAll(params);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(param.getInt("pageNo") > 0 ? param.getInt("pageNo") : 1); // 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(30); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(5); // 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		vo.setFirstRecordIndex(firstRecordIndex);
		vo.setRecordCountPerPage(recordCountPerPage);
		vo.setSection(gubun);
		// fna list
		List<Wiki> fna_list = service.getWikiList(vo);
		int fna_cnt = service.getWikiListCount(vo);

		model.addAttribute("result", fna_list);
		model.addAttribute("fna_cnt", fna_cnt);
		model.addAttribute("gubun", gubun);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/wiki/HelpList";
	}


	@RequestMapping("/view/{wikino}/{gubun}")
	public String view(HttpServletRequest request, @PathVariable("wikino") int wikino,
			@PathVariable("gubun") String gubun, LoginVO user, Model model, HttpSession httpSession) throws Exception {

		user = (LoginVO) httpSession.getAttribute("userSession");

		Wiki wiki_view = service.getView(wikino);
		model.addAttribute("result", wiki_view);

		List<WikiHistory> history = service.getHistory(wikino);
		model.addAttribute("history", history);
		model.addAttribute("gubun", gubun);

		return "/wiki/view";
	}


	@RequestMapping("/helpview/{wikino}/{gubun}")
	public String helpview(HttpServletRequest request, @PathVariable("wikino") int wikino,
			@PathVariable("gubun") String gubun, Model model, HttpSession httpSession) throws Exception {
		System.out.println("gubun===" + gubun);
		Wiki wiki_view = service.getView(wikino);
		model.addAttribute("result", wiki_view);

		return "/wiki/helpView";
	}


	@RequestMapping("/edit/{seq}")
	public String historyView(HttpServletRequest request, @PathVariable("seq") int seq, LoginVO user, Model model,
			HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		WikiHistory wiki_history_view = service.getHistoryView(seq);

		// System.out.println("wiki_history_view wikino--> " + wiki_history_view.getWikino());
		model.addAttribute("history_view", wiki_history_view);
		// System.out.println(wiki_history_view.getTitle());

		return "/wiki/view";
	}


	@RequestMapping("/saveHelp/{gubun}")
	public String createHelp(HttpServletRequest request, LoginVO user, Wiki vo, Model model,
			@PathVariable("gubun") String gubun, HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";

		} else {
			System.out.println("userno ==>" + user.getUserno());

			model.addAttribute("gubun", gubun);
			return "/wiki/createHelp";
		}
	}


	@RequestMapping("/saveWiki")
	public String saveWiki(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession)
			throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user == null) {
			model.addAttribute("ret", "wiki 문서 작성/수정은 로그인시에만 가능합니다!");
			return "redirect:/login";

		} else {
			List<Wiki> tagList = qs.findAllTag();
			model.addAttribute("tagList", tagList);

			return "/wiki/createWiki";
		}

	}


	@RequestMapping("/save.proc")
	public String save(HttpServletRequest request, LoginVO user, Wiki vo, RedirectAttributes model,
			HttpSession httpSession, HttpServletResponse response) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		vo.setUserno(user.getUserno());

		String retunUrl = "";
		String gubun = request.getParameter("gubun");
		System.out.println("section? " + vo.getSection());

		if (vo.getSection().equals("h")) {
			retunUrl = "/wiki/Help/h";
		} else if (vo.getSection().equals("m")) {
			retunUrl = "/wiki/Help/m";
		} else if (vo.getSection().equals("t")) {
			retunUrl = "/tags/list";
		} else if (vo.getSection().equals("w")) {
			retunUrl = "/wiki/Help/w";
		} else {
			retunUrl = "/wiki/getStart";
		}

		int ret = service.checkDuplication(vo);

		if (ret > 0) { // 중복된경우
			model.addFlashAttribute("message", "중복된 정보입니다. 확인해보고 작성해주세요.");
			return "redirect:" + retunUrl;

		} else { // 중복이 아닌 경우 문서 생성
			service.saveHistory(vo);
			return "redirect:" + retunUrl;
		}

	}


	@RequestMapping("/edit.proc")
	public String edit(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpSession httpSession)
			throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		if (user != null) {
			vo.setUserno(user.getUserno());
			service.updateWiki(vo);

		} else {
			return "redirect:/login";
		}
		String retunUrl = "";

		if (vo.getSection().equals("h")) {
			retunUrl = "/wiki/Help/h";
		} else if (vo.getSection().equals("m")) {
			retunUrl = "/wiki/Help/m";
		} else if (vo.getSection().equals("t")) {
			retunUrl = "/tags/list";
		} else if (vo.getSection().equals("w")) {
			retunUrl = "/wiki/Help/w";
		} else {
			retunUrl = "/wiki/getStart";
		}
		return "redirect:" + retunUrl;
		// return "redirect:/wiki/getStart";
	}


	@RequestMapping("/delete.proc")
	public String delete(HttpServletRequest request, LoginVO user, Wiki vo, Model model, HttpServletResponse response,
			HttpSession httpSession) throws Exception {
		user = (LoginVO) httpSession.getAttribute("userSession");
		String retunUrl = "";

		if (user != null) {
			vo.setUserno(user.getUserno());
			service.updateWiki(vo);

			int ret = 0;
			ret = service.deleteWiki(vo.getWikino());
			System.out.println("section? " + vo.getSection());

			if (vo.getSection().equals("h")) {
				retunUrl = "/wiki/Help/h";
			} else if (vo.getSection().equals("m")) {
				retunUrl = "/wiki/Help/m";
			} else if (vo.getSection().equals("t")) {
				retunUrl = "/tags/list";
			} else if (vo.getSection().equals("w")) {
				retunUrl = "/wiki/Help/w";
			} else {
				retunUrl = "/wiki/getStart";
			}

			if (ret == 0) {
				System.out.println("위키 문서 삭제 실패");
				request.setAttribute("message", messageSource.getMessage("com.test", null, Locale.getDefault()));
				request.setAttribute("url", retunUrl);
				request.getRequestDispatcher("/login/message").forward(request, response);

			} else {
				System.out.println("위키 문서 정상적으로 삭제");
				request.setAttribute("message", messageSource.getMessage("delete.success", null, Locale.getDefault()));
				request.setAttribute("url", retunUrl);
				request.getRequestDispatcher("/login/message").forward(request, response);

			}
		} else {
			retunUrl = "/login";
		}

		return "redirect:" + retunUrl;

	}

}
