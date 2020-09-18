package com.de.tag;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.de.wiki.Wiki;
import com.de.wiki.service.WikiService;


@Controller
@RequestMapping(value = "/tags")
public class TagsController {

	@Autowired
	WikiService service;
	
	
	@RequestMapping("/list")
	public String tagslist(Wiki vo, Model model)throws Exception {
		System.out.println("--------tag list 출력--------");
		
		List<Wiki> get_list = service.getWikiList("t");
		//List <Integer> tagno_cnt= new ArrayList<>();
		int [] tagno_cnt = new int[get_list.size()];
		for(int i=0;i<get_list.size();i++) {
			System.out.println(get_list.get(i).getWikino()+" : "+get_list.get(i).getTitle()+"\n : "+ get_list.get(i).getContents());			
			tagno_cnt[i] = service.getWikiCount(get_list.get(i).getWikino());
			System.out.println(get_list.get(i).getWikino()+" 번 태그가 포함된 질문 갯수-->" +tagno_cnt[i]);
			System.out.println("-------------------------------------------------------------");
			get_list.get(i).setRelatedcnt(tagno_cnt[i]);
		}
		
		
		model.addAttribute("result", get_list);
		
		return "/tags/list";
	}

}
