package com.de.user.mapper;

import java.util.List;

import com.de.enterprise.Enterprises;
import com.de.question.Questions;
import com.de.user.UserPwVO;
import com.de.user.Users;
import com.de.user.UsersDetail;
import com.de.wiki.Wiki;

public interface UsersMapper {
//	public Optional<Enterprises> findEnterpriseno(int seq);
	public Enterprises findEnterpriseno(int seq);
	public int updateUserPw(UserPwVO vo);
	public void updateUserProfileImg(Users vo);
	public List<Enterprises> getEnterList(Enterprises vo);
	public void updateEnterpriseNo(UsersDetail vo);
	public List<Questions> getQuestionsList(Questions vo);
	public int cntQuestionsById(int seq);
	public int cntAnswerById(int seq);
	public int cntTagAndWikiById(Wiki vo);
	public List<Wiki> findTagAndWikiByUserno(Wiki vo);
	public Integer getScore(int seq);
	public String getScoregraph(int userno);
	public List<Users> getList(Users vo) throws Exception;
	public int getListCount(Users vo) throws Exception;
	public Users getView(int userno) throws Exception;
}