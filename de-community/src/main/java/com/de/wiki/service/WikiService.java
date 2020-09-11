package com.de.wiki.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.wiki.Wiki;
import com.de.wiki.mapper.WikiMapper;

@Service
@Transactional
public class WikiService {
	@Autowired
	WikiMapper mapper;

	// 위키문서 저장
	public Wiki getWikiHelp(Wiki vo)throws Exception{
		return mapper.getWikiHelp(vo);		
	};

	
	// 위키문서 저장
	public int save(Wiki vo)throws Exception{
		return mapper.save(vo);		
	};
	
	public int saveHistory(Wiki vo)throws Exception{
		return mapper.saveHistory(vo);		
	};
}
