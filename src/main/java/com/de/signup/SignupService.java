package com.de.signup;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
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
		return sr.save(vo);
	}
	
	public UsersDetail save(UsersDetail vo) {		
		return sd.save(vo);
	}
		

}


