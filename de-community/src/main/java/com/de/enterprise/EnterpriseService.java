package com.de.enterprise;

import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.de.answer.Answers;
import com.de.answer.AnswersRepository;
import com.de.enterprise.mapper.EnterprisesMapper;
import com.de.question.Questions;
import com.de.question.QuestionsRepository;
import com.de.user.Users;
import com.de.user.UsersDetail;
import com.de.wiki.Wiki;

@Service
@Transactional
public class EnterpriseService {
	
	@Autowired
	EnterprisesRepository er;
	
	@Autowired
	EnterprisesMapper em;
	
	@Autowired
	QuestionsRepository qr;
	
	@Autowired
	AnswersRepository ar;

	public Optional<Enterprises> findByEnterpriseno(int seq) throws Exception {
		return er.findByEnterpriseno(seq);
	}
	
	// 기업 목록
	public Page<Enterprises> findAll(Pageable pageable) throws Exception {
		int page = (pageable.getPageNumber() == 0) ? 0 : (pageable.getPageNumber() - 1);

		// 기본 정렬 설정
		String[] sort = pageable.getSort().toString().split(": ");
		String sortColumn = "registerdate";
		Direction direction = Sort.Direction.DESC;

		// 사용자 설정에 따른 변경
		if(1 < sort.length && !"UNSORTED".equals(sort[0])) {
			if("ASC".equals(sort[1])) direction = Sort.Direction.ASC;
			sortColumn = sort[0];
		}

		pageable = PageRequest.of(page, 30, new Sort(direction, sortColumn));
		Page<Enterprises> list = er.findAll(pageable);
		return list;
	}
	
	// 정보 업데이트
	public int updateEnterprises(Enterprises vo) throws Exception {
		
		
		return em.updateEnterprises(vo);
	}

	
	// 비밀번호 변경
	public boolean updateEnterprisePw(EnterprisePwVO vo) {
		boolean updateVal = false;
		Optional<Enterprises> e = er.findById(vo.getEnterpriseno());
		
		if (e.isPresent()) {
			int check = em.updateEnterprisePw(vo);
			if(check == 1) updateVal = true;
		}
		return updateVal;
	}
	
	// 프로필 사진 변경
	public boolean upload(Enterprises vo, MultipartHttpServletRequest request) throws Exception {
		boolean updateVal = false;
		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String path = root_path.split("/webapp")[0] + "/resources/static/upload/enterprises/";

		List<MultipartFile> fileList = request.getFiles("profileImg"); 
		File fileDir = new File(path); 
		
		if (!fileDir.exists()) { 
			fileDir.mkdirs(); 
		} 
		long time = System.currentTimeMillis(); 
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			
			// 원본 파일명
			String saveFileName = String.format("%d_%s", time, originFileName);
			
			// 파일 확장자명 추출
			Integer mid = saveFileName.lastIndexOf(".");
			saveFileName = vo.getEnterpriseno() + saveFileName.substring(mid, saveFileName.length());
			
			vo.setEnterpriseimg(saveFileName);
			
			try {
				// 파일생성
				mf.transferTo(new File(path, saveFileName));
				
				// DB 저장
				em.updateEnterprisesimg(vo);
				
				updateVal = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return updateVal;
	}

	// 기업 회원 목록
	public List<Users> getMembersList(UsersDetail vo) {
		return em.getMembersList(vo);
	}
	
	public boolean updateActivaet(UsersDetail vo) {
		return em.updateActivaet(vo);
	}

	public boolean updateUserat(UsersDetail vo) {
		return em.updateUserat(vo);
	}

	// 내 질문 등록 수
	public int cntQuestionsById(int seq) {
		return em.cntQuestionsById(seq);
	}
	
	// 내 질문 목록 - 최근 5개
	public Page<Questions> findQuestionsByUserno(int seq) {
		Pageable pageable = PageRequest.of(0, 5, new Sort(Sort.Direction.DESC, "registerdate"));
		Page<Questions> list = qr.findAllByUserno(seq, pageable);
		return list;
	}

	// 내 답변 등록 수
	public int cntAnswerById(int seq) {
		return em.cntAnswerById(seq);
	}
	
	// 내 답변 목록 - 최근 5개
	public Page<Answers> findAnswerByUserno(int seq) {
		Pageable pageable = PageRequest.of(0, 5, new Sort(Sort.Direction.DESC, "registerdate"));
		Page<Answers> list = ar.findAllByUserno(seq, pageable);
		return list;
	}

	// 내 태그/위키 등록 수
	public int cntTagAndWikiById(Wiki vo) {
		return em.cntTagAndWikiById(vo);
	}
	
	// 내 태그/위키 목록 - 최근 5개
	public List<Wiki> findTagAndWikiByUserno(Wiki vo) {
		return em.findTagAndWikiByUserno(vo);
	}
	
	// 평판점수
	public Integer getScore(int seq) {
		return em.getScore(seq);
	}
	
	// 기업홍보문구를 작성한 회사 리스트 - 최든 5개
	public List<Enterprises> getPromteList(){		
		return em.getPromteList();
	}
}