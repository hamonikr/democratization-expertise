package com.de.enterprise.mapper;

import java.util.List;

import com.de.enterprise.EnterprisePwVO;
import com.de.enterprise.Enterprises;
import com.de.user.Users;
import com.de.user.UsersDetail;
import com.de.wiki.Wiki;

public interface EnterprisesMapper {
	public int updateEnterprises(Enterprises vo);
	public int updateEnterprisePw(EnterprisePwVO vo);
	public void updateEnterprisesimg(Enterprises vo);
	public List<Users> getMembersList(UsersDetail vo);
	public List<Users> getActiveatMembersList(UsersDetail vo);
	public boolean updateActivaet(UsersDetail vo);
	public boolean updateUserat(UsersDetail vo);
	public int cntQuestionsById(int seq);
	public int cntAnswerById(int seq);
	public int cntTagAndWikiById(Wiki vo);
	public List<Wiki> findTagAndWikiByUserno(Wiki vo);
	public Integer getScore(int seq);
}