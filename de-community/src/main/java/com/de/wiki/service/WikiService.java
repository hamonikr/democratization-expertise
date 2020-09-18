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
	public List<Wiki> getWikiList(String section) throws Exception{
		return mapper.getWikiList(section);		
	}

	// view 페이지 불러오기
	public Wiki getView(int wikino) throws Exception{		
		return	mapper.getView(wikino);
	}
	
	//과거 내역 불러오기
	public WikiHistory getHistoryView(int seq) throws Exception{
		return mapper.getHistoryView(seq);
	}
	
	// 히스토리 리스트 불러오기 
	public List<WikiHistory> getHistory(int wikino) throws Exception{
		return mapper.getHistory(wikino);
	}
	
	// 질문 갯수 가져오기
	public int getWikiCount(int tagno)throws Exception{
		return mapper.getWikiCount(tagno);
	}
	
	// 위키문서 저장
	public int save(Wiki vo)throws Exception{
//		saveHistory(vo);
		return mapper.save(vo);		
	}
	//위키 히스토리 저장
	public int saveHistory(Wiki vo)throws Exception{
			save(vo);
		return mapper.saveHistory(vo);		
	}
	
	// 위키 문서 수정 - 히스토리 저장
 	public int updateWiki(Wiki vo)throws Exception{
 		 addWikiHistory(vo);
		return mapper.updateWiki(vo);
	}
	public int addWikiHistory(Wiki vo)throws Exception{
		return mapper.addWikiHistory(vo);
	}

 	
	// 위키문서 삭제
	public int deleteWiki(int wikino)throws Exception{		
		return mapper.deleteWiki(wikino);
	}


}
