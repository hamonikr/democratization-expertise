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

	public LoginVO findByUserEmail(String email)throws Exception{
		return mapper.findByUserEmail(email);		
	};
	
}
