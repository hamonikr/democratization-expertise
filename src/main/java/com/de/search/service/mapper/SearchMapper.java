package com.de.search.service.mapper;

import com.de.search.service.vo.UserInfoVO;

public interface SearchMapper {
	
	
	public UserInfoVO findUserInfo(UserInfoVO vo) throws Exception;
	
	public String findBizcd(UserInfoVO vo) throws Exception;
	
	public int resetUserPw(UserInfoVO vo) throws Exception;
	
	public int checkUserID(UserInfoVO vo) throws Exception;	
		
}


