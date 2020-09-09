package com.de.signup;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.de.user.Users;
import com.de.user.UsersDetail;


@Service
@Transactional
public class SignupService {
	@Autowired
	private SignupRepository sr;
	@Autowired
	private SignupForDetailRepository sd;
	
	public Users save(Users vo) {	
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpassword(passwordEncoder.encode(vo.getUserpassword()));
		vo.setRole(1);
		return sr.save(vo);
	}
	
	public UsersDetail save(UsersDetail vo) {		
		return sd.save(vo);
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
	
	public boolean bizNoCheck (UsersDetail vo) {		
		List<UsersDetail> bizExt = sd.findByEnterpriseno(vo.getEnterpriseno());
		return bizExt.listIterator().hasNext();
	}
	
}


