package com.de.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.login.mapper.LoginMapper;
import com.de.login.vo.LoginHistoryVO;
import com.de.login.vo.LoginVO;

@Service
public class LoginService {
	
	@Autowired
	LoginMapper mapper;
	
	public LoginVO getUserInfo(String username) throws Exception{
		return mapper.getUserInfo(username);
	}
	
	public LoginVO getSocialUserInfo(String username) throws Exception{
		return mapper.getSocialUserInfo(username);
	}
	
	public int saveLoginHistory(LoginHistoryVO vo) throws Exception{
		return mapper.saveLoginHistory(vo);
	}
	
}
