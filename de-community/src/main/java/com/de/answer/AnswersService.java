package com.de.answer;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.answer.mapper.AnswersMapper;
import com.de.question.mapper.QuestionsMapper;
import com.de.tag.Tags;
import com.de.tag.TagsRepository;
import com.de.vote.Vote;
import com.de.vote.VoteRepository;
import com.de.wiki.Wiki;
import com.de.wiki.WikiRepository;


@Service
@Transactional
public class AnswersService {
	
	@Autowired
	AnswersRepository ar;
	
	@Autowired
	AnswersMapper am;
	
	@Autowired
	QuestionsMapper qm;
	
	@Autowired
	TagsRepository tr;
	
	@Autowired
	WikiRepository wr;
	
	@Autowired
	VoteRepository vr;
	
//	public Page<Answers> findAll(Pageable pageable){
//		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
//        pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerdate"));
//		Page<Answers> list = ar.findAllByDeleteat(0,pageable);
//
//		return list;
//	}
	
//	// 게시물 목록
//	public List<Answers> getList(Answers vo) throws Exception {
//		return qm.getList(vo);
//	}
//	// 게시물 카운트
//	public int getListCount(Answers vo) throws Exception {
//		return qm.getListCount(vo);
//	}
//	// 게시물 상세
//	public Answers getView(int questionno) throws Exception {
//		return qm.getView(questionno);
//	}
	//조회수 증가
	public int updateReanCnt(int questionno) throws Exception {
		return qm.updateReanCnt(questionno);
	}
	
	public Optional<Answers> findById(int questionno) throws Exception{
		return ar.findById(questionno);
	}
	
	public List<Answers> findAllByquestionno(int questionno) throws Exception{
		return ar.findAllByquestionno(questionno);
	}
	
	public List<Answers> getList(int questionno) throws Exception{
		return am.getList(questionno);
	}
	
	public Answers save(Answers vo) throws Exception {
		
		return ar.save(vo);
	}
	//tag 목록
	public List<Wiki> findAllTag(){
		//int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
        //pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerdate"));
		List<Wiki> list = wr.findAllBySectionAndDeleteat("t",0);

		return list;
	}
	public List<Tags> tagList() throws Exception {
		
		return tr.findAll();
		
	}
	
	public List<Vote> voteList() throws Exception {
		
		return vr.findAll();
		
	}
	
//	public void updateById(Answers vo) throws Exception {
//		Optional<Answers> e = qr.findById(vo.getQuestionno());
//		CmmnMap param = new CmmnMap();
//		param.put("questionno",e.get().getQuestionno());
//		param.put("contents",e.get().getContents());
//		param.put("section",e.get().getSection());
//		param.put("title",e.get().getTitle());
//		param.put("deleteat",e.get().getDeleteat());
//		param.put("editauth",e.get().getEditauth());
//		param.put("readcnt",e.get().getReadcnt());
//		param.put("registerdate",e.get().getRegisterdate());
//		param.put("tagno",e.get().getTagno());
//		param.put("updatedate",e.get().getUpdatedate());
//		param.put("userno",e.get().getUserno());
//		qm.insertHistory(param);
//
//		if (e.isPresent()) {
//			e.get().setContents(vo.getContents());
//			e.get().setTitle(vo.getTitle());
//			e.get().setUserno(vo.getUserno());
//			e.get().setTagno(vo.getTagno());
//			e.get().setReadcnt(e.get().getReadcnt());
//			e.get().setEditauth(vo.getEditauth());
//			qr.save(vo);
//		}
//
//  }
	public Answers updateHistory(Answers vo) throws Exception {
		
		return ar.save(vo);
	}
	
//	public void updateByIdReadCnt(Answers vo) throws Exception {
//	Optional<Answers> e = qr.findById(vo.getQuestionno());
//	if (e.isPresent()) {
//		e.get().setReadcnt(vo.getReadcnt() +1);
//		qr.save(vo);
//	}
//
//}

}
