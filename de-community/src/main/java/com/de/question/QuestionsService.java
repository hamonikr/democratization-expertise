package com.de.question;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.de.question.mapper.QuestionsMapper;
import com.de.tag.Tags;
import com.de.tag.TagsRepository;
import com.de.vote.Vote;
import com.de.vote.VoteRepository;


@Service
@Transactional
public class QuestionsService {
	
	@Autowired
	QuestionsRepository qr;
	
	@Autowired
	QuestionsMapper qm;
	
	@Autowired
	TagsRepository tr;
	
	@Autowired
	VoteRepository vr;
	
	public Page<Questions> findAll(Pageable pageable){
		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
        pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerDate"));
		Page<Questions> list = qr.findAllByDeleteat(0,pageable);

		return list;
	}
	
	// 게시물 목록
	public List<Questions> getList(Questions vo) throws Exception {
		return qm.getList(vo);
	}
	// 게시물 카운트
	public int getListCount(Questions vo) throws Exception {
		return qm.getListCount(vo);
	}
	// 게시물 상세
	public Questions getView(int questionno) throws Exception {
		return qm.getView(questionno);
	}
	//조회수 증가
	public int updateReanCnt(int questionno) throws Exception {
		return qm.updateReanCnt(questionno);
	}
	
	public Optional<Questions> findById(int questionNo) {
		return qr.findById(questionNo);
	}
	
	public Questions save(Questions vo) {
		
		return qr.save(vo);
	}
	
	public List<Tags> tagList() {
		
		return tr.findAll();
		
	}
	
	public List<Vote> voteList() {
		
		return vr.findAll();
		
	}
	
//	public void updateById(Questions vo) {
//		Optional<Questions> e = qr.findById(vo.getSeq());
//		if (e.isPresent()) {
//			e.get().setContents(vo.getContents());
//			e.get().setTitle(vo.getTitle());
//			qr.save(vo);
//		}
//
//  }
	
	public void updateByIdReadCnt(Questions vo) {
	Optional<Questions> e = qr.findById(vo.getQuestionno());
	if (e.isPresent()) {
		e.get().setReadcnt(vo.getReadcnt() +1);
		qr.save(vo);
	}

}

}
