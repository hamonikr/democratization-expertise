package com.de.answer.mapper;


import java.util.List;

import com.de.answer.Answers;
import com.de.cmmn.CmmnMap;
import com.de.question.Questions;


public interface AnswersMapper {

	public List<Answers> getList(int questionno) throws Exception;

	public int getListCount(int questionno) throws Exception;

	public Questions getView(int questionno) throws Exception;

	public int updateReanCnt(int questionno) throws Exception;

	public int insertHistory(CmmnMap param) throws Exception;

	public List<Questions> getMyList(Questions vo) throws Exception;

	public List<Questions> getCompQuestionList(String useruuid) throws Exception;

	public int getCompQuestionListCount(String useruuid) throws Exception;

	public Questions getAnswerComplete() throws Exception;

}