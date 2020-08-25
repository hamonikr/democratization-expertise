package com.de.security.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.de.security.LoginVO;

@Mapper
public interface SecurityMapper {
	
	public LoginVO findByUserEmail(String email)throws Exception;
}
