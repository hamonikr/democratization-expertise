package com.de.signup;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.de.enterprise.Enterprises;
import com.de.signup.mapper.SignupMapper;
import com.de.user.Users;
import com.de.user.Usersdetail;


@Service
@Transactional
public class SignupService {
	@Autowired
	private SignupRepository sr;
	@Autowired
	private SignupForDetailRepository sd;
	
	@Autowired
	private SignupMapper mapper;
	
	public Users save(Users vo) {	
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpassword(passwordEncoder.encode(vo.getUserpassword()));
		vo.setRole(1);
		return sr.save(vo);
	}
	
	public int saveEnterprisebizno(Enterprises vo) throws Exception{
		return mapper.saveEnterprisebizno(vo);
	}
	
	public int getEnterpriseno(Enterprises vo) throws Exception{		
		return mapper.getEnterpriseno(vo);
	}
	public Integer bizNoCheck(Enterprises vo) throws Exception{
		return mapper.bizNoCheck(vo);
	}

	
	public int saveDetail(Usersdetail vo) throws Exception {	
		return mapper.saveDetail(vo);
	}

	public boolean isExist (String email) {		
		return sr.existsByUseremail(email); 
	}
	
	public boolean idCheck (Users vo) {		
		List<Users> idExt = sr.findByUserid(vo.getUserid());
		return idExt.listIterator().hasNext();
	}
	
	public boolean emCheck (Users vo) {		
		List<Users> emExt = sr.findByUseremail(vo.getUseremail());
		return emExt.listIterator().hasNext();
	}
	
//	public boolean bizNoCheck (UsersDetail vo) {		
//		List<UsersDetail> bizExt = sd.findByEnterpriseno(vo.getEnterpriseno());
//		return bizExt.listIterator().hasNext();
//	}
	
}


