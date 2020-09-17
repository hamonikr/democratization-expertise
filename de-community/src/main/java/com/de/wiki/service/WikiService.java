package com.de.wiki.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.wiki.Wiki;
import com.de.wiki.WikiHistory;
import com.de.wiki.mapper.WikiMapper;

@Service
@Transactional
public class WikiService {
	@Autowired
	WikiMapper mapper;

	// helps 불러오기
	public List<Wiki> getWikiHelp()throws Exception{
		return mapper.getWikiHelp();		
	}

	// tag 불러오기
	public List<Wiki> getWikiTag()throws Exception{
			return mapper.getWikiHelp();		
		}

	// view 페이지 불러오기
	public Wiki getView(int wikino) throws Exception{		
		return	mapper.getView(wikino);
	}
	
	//과거 ㄴ내역 불러오기
	public WikiHistory getHistoryView(int seq) throws Exception{
		return mapper.getHistoryView(seq);
	}

	
	// 히스토리 리스트 불러오기 
	public List<WikiHistory> getHistory(int wikino) throws Exception{
		return mapper.getHistory(wikino);
	}
	// 위키문서 저장
	public int save(Wiki vo)throws Exception{
		return mapper.save(vo);		
	}
	//위키 히스토리 저장
	public int saveHistory(Wiki vo)throws Exception{
		return mapper.saveHistory(vo);		
	}
	
	public int updateWiki(Wiki vo)throws Exception{
			saveHistory(vo);
		return mapper.updateWiki(vo);
	}
	// 위키문서 삭제
	public int deleteWiki(int wikino)throws Exception{		
		return mapper.deleteWiki(wikino);
	}


}
