package com.de.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.security.LoginVO;
import com.de.security.mapper.SecurityMapper;

@Service
@Transactional
public class SecurityService {
	@Autowired
	SecurityMapper mapper;
//
//	public int loginCheck(String id, String pw)throws Exception{
//		return mapper.loginCheck(id, pw);
//	}
	
	public LoginVO findUser(String email)throws Exception{
		return mapper.findUser(email);		
	};
	
	public int saveSnsAccount(LoginVO  vo)throws Exception{
		return mapper.saveSnsAccount(vo);
	};

}
