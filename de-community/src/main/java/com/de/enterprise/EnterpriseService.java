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

import com.de.enterprise.mapper.EnterprisesMapper;
import com.de.user.Users;
import com.de.user.UsersDetail;

@Service
@Transactional
public class EnterpriseService {
	
	@Autowired
	EnterprisesRepository er;
	
	@Autowired
	EnterprisesMapper em;

	public Optional<Enterprises> findById(int seq) throws Exception {
		return er.findById(seq);
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

		pageable = PageRequest.of(page, 5, new Sort(direction, sortColumn));
		Page<Enterprises> list = er.findAll(pageable);
		return list;
	}
	
	// 정보 업데이트
	public void updateEnterprises(Enterprises vo) throws Exception {
		Optional<Enterprises> enter = er.findById(vo.getEnterpriseno());
		
		if (enter.isPresent()) {
			// 수정
			enter.get().setEnterprisebizno(vo.getEnterprisebizno());
			enter.get().setEnterprisename(vo.getEnterprisename());
			enter.get().setEnterpriseabout(vo.getEnterpriseabout());
			enter.get().setEnterpriseemail(vo.getEnterpriseemail());
			enter.get().setEnterpriseurl(vo.getEnterpriseurl());
			enter.get().setEnterprisearea(vo.getEnterprisearea());
			
			// 유지
			vo.setEnterpriseid(enter.get().getEnterpriseid());
			vo.setEnterprisepassword(enter.get().getEnterprisepassword());
			vo.setEnterpriseimg(enter.get().getEnterpriseimg());
			vo.setEnterpriseat(enter.get().getEnterpriseat());
			vo.setRegisterdate(enter.get().getRegisterdate());
			
			er.save(vo);
		}
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
}