package com.de.enterprise.mapper;

import java.util.List;

import com.de.enterprise.EnterprisePwVO;
import com.de.enterprise.Enterprises;
import com.de.user.Users;
import com.de.user.Usersdetail;
import com.de.wiki.Wiki;

public interface EnterprisesMapper {
	public int updateEnterprises(Enterprises vo);
	public int updateEnterprisePw(EnterprisePwVO vo);
	public void updateEnterprisesimg(Enterprises vo);
	public List<Users> getMembersList(Usersdetail vo);
	public List<Users> getActiveatMembersList(Usersdetail vo);
	public boolean updateActivaet(Usersdetail vo);
	public boolean updateUserat(Usersdetail vo);
	public int cntQuestionsById(int seq);
	public int cntAnswerById(int seq);
	public int cntTagAndWikiById(Wiki vo);
	public List<Wiki> findTagAndWikiByUserno(Wiki vo);
	public Integer getScore(List<Users> memList);
	public List<Enterprises> getPromteList();
	public String getScoregraph(List<Users> memList);
}