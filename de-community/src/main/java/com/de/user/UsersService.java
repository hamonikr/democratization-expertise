package com.de.user;

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

import com.de.enterprise.Enterprises;
import com.de.enterprise.EnterprisesRepository;
import com.de.newsletteruser.MailingUserRepository;
import com.de.user.mapper.UsersMapper;

@Service
@Transactional
public class UsersService {
	private final int NEWSLATTER_NO = 0;
	private final int NEWSLATTER_YES = 1;
	
	@Autowired
	UsersRepository ur;
	
	@Autowired
	EnterprisesRepository er;
	
	@Autowired
	MailingUserRepository mr;
	
	@Autowired
	UsersMapper um;

	public Optional<Users> findById(int seq) throws Exception {
		return ur.findById(seq);
	}
	
	public Optional<Enterprises> findEnterpriseNo(int seq) throws Exception {
		return um.findEnterpriseNo(seq);
	}
	
	// 목록
	public Page<Users> findAll(Pageable pageable) throws Exception {
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
		Page<Users> list = ur.findAll(pageable);
		return list;
	}
	
	// 정보 업데이트
	public void updateUser(Users vo, UsersDetail userDetail) throws Exception {
		Optional<Users> users = ur.findById(vo.getUserno());
		Optional<Enterprises> enterprises = null;
		
		// find enterprise information
		if(userDetail != null && userDetail.getEnterpriseno() != null) {
			enterprises = er.findById(userDetail.getEnterpriseno());
		}
		
		// update user information
		if (users.isPresent()) {
			users.get().setUsername(vo.getUsername());
			users.get().setUseremail(vo.getUseremail());
			users.get().setAboutme(vo.getAboutme());
			users.get().setUserurl(vo.getUserurl());
			
			vo.setUserid(users.get().getUserid());
			vo.setUserpassword(users.get().getUserpassword());
			vo.setUserstatus(users.get().getUserstatus());
			vo.setRegisterdate(users.get().getRegisterdate());
			
			ur.save(vo);
		}
		
		// update userDetail enterpriseNo
		userDetail.setUserno(users.get().getUserno());
		if( !( enterprises != null && enterprises.isPresent() ) ) {
			userDetail.setEnterpriseno(null);
		}
		um.updateEnterpriseNo(userDetail);
		
		// 뉴스레터 업데이트
//		Optional<MailingUserList> mailingUser = mr.findById(vo.getUserNo());
//		if(mailingUser.isPresent()) {
//			if(newslater) mailingUser.get().setActive(NEWSLATTER_YES);
//			else mailingUser.get().setActive(NEWSLATTER_NO);
//			
//			mailingUser.get().setEmail(vo.getUserEmail());
//			mailingUser.get().setName(vo.getUserName());
//			mr.save(mailingUser.get());
//		}
	}

	// 비밀번호 변경
	public boolean updateUserPw(UserPwVO vo) {
		boolean updateVal = false;
		Optional<Users> e = ur.findById(vo.getUserno());
		
		if (e.isPresent()) {
//			if(e.get().getUserPassword().equals(vo.getUserPassword())) {
//				e.get().setUserPassword(vo.getUserPasswordNew());
				int check = um.updateUserPw(vo);
				if(check == 1) updateVal = true;
//			}
		}
		return updateVal;
	}

	// 프로필 사진 변경
	public boolean upload(Users vo, MultipartHttpServletRequest request) throws Exception {
		boolean updateVal = false;
		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String path = root_path.split("/webapp")[0] + "/resources/static/upload/";

		
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
			saveFileName = vo.getUserno() + saveFileName.substring(mid, saveFileName.length());
			
			vo.setUserprofileimg(saveFileName);
			
			try {
				// 파일생성
				mf.transferTo(new File(path, saveFileName));
				
				// DB 저장
				um.updateUserProfileImg(vo);
				
				updateVal = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return updateVal;
	}

	// 회사 목록
	public List<Enterprises> getEnterList(String enterName) {
		Enterprises vo = new Enterprises();
		vo.setEnterpriseat(1);
		vo.setEnterprisename(enterName);
		List<Enterprises> list = um.getEnterList(vo);
		return list;
	}
}