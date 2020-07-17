package com.de.signup;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
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
		vo.setUserPassword(passwordEncoder.encode(vo.getUserPassword()));
		return sr.save(vo);
	}
	
	public UsersDetail save(UsersDetail vo) {		
		return sd.save(vo);
	}

	public boolean isExist (String email) {		
		return sr.existsByUserEmail(email); 
	}

	
}


