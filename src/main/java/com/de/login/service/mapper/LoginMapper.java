package com.de.login.service.mapper;

import com.de.user.service.UserVO;

public interface LoginMapper {
	
	//public UserVO getUser(UserVO vo) throws Exception;
	
	public UserVO getUser(String username) throws Exception;
	
	public int signUp(UserVO vo) throws Exception;
	

}
