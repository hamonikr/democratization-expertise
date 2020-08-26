package com.de.security.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.de.security.LoginVO;

@Mapper
public interface SecurityMapper {
//	public int loginCheck(String id, String pw)throws Exception;

	public LoginVO findUser(String email)throws Exception;
	
	public int saveSnsAccount(LoginVO  vo)throws Exception;
	
}
