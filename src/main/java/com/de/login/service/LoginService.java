package com.de.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.login.service.mapper.LoginMapper;
import com.de.user.service.UserVO;

@Service
@Transactional
public class LoginService { 
	@Autowired
	LoginMapper lMapper;

	//회원가입
	@Transactional
	public int signUp(UserVO vo) throws Exception {
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUser_passwd(passwordEncoder.encode(vo.getUser_passwd()));

		return lMapper.signUp(vo);
	}
	

}
