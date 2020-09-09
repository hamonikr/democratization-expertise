package com.de.vote;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.vote.mapper.VoteMapper;


@Service
@Transactional
public class VoteService {
	
	@Autowired
	VoteRepository vr;
	
	@Autowired
	VoteMapper vm;
	
	public int likes(Vote vo) throws Exception{
		return vm.likes(vo);
	}
	
	public int dislikes(Vote vo) throws Exception{
		return vm.dislikes(vo);
	}
	
	public int save(Vote vo) throws Exception{
		return vm.save(vo);
	}
	
	public Vote getSeq(Vote vo) throws Exception{
		return vm.getSeq(vo);
	}
	
	public int saveVoteUser(Vote vo) throws Exception{
		return vm.saveVoteUser(vo);
	}
	
	public int voteCheck(Vote vo) throws Exception{
		return vm.voteCheck(vo);
	}
//	public Page<Vote> findAll(Pageable pageable){
//		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1); // page는 index 처럼 0부터 시작
//        pageable = PageRequest.of(page, 5,new Sort(Sort.Direction.DESC,"registerDate"));
//		Page<Vote> list = vr.findAllByDeleteAt(0,pageable);
//
//		return list;
//	}
	
	public Optional<Vote> findById(int questionNo) {
		return vr.findById(questionNo);
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
	
//	public void updateByIdReadCnt(Vote vo) {
//	Optional<Vote> e = vr.findById(vo.getQuestionNo());
//	if (e.isPresent()) {
//		e.get().setReadCnt(vo.getReadCnt() +1);
//		vr.save(vo);
//		}
//
//	}

}
