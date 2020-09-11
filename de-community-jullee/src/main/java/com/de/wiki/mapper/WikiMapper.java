package com.de.wiki.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.de.wiki.Wiki;

@Mapper
public interface WikiMapper {
	
	
	public List<Wiki> getWikiHelp()throws Exception;
	public List<Wiki> getWikiTag()throws Exception;
	public int save(Wiki vo)throws Exception;
	public int saveHistory(Wiki vo)throws Exception;
}
