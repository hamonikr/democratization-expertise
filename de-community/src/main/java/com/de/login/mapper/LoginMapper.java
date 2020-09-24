package com.de.login.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.de.login.vo.LoginVO;

@Mapper
public interface LoginMapper {

	public LoginVO getUser(String username) throws Exception;
	public LoginVO getUserInfo(String username) throws Exception;
	
}
