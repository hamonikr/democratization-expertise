package com.hamonize.search.service.mapper;

import com.hamonize.search.service.vo.UserInfoVO;

public interface SearchMapper {
	
	
	public UserInfoVO findUserInfo(UserInfoVO vo) throws Exception;
	
	public String findBizcd(UserInfoVO vo) throws Exception;
	
	public int resetUserPw(UserInfoVO vo) throws Exception;
	
	public int checkUserID(UserInfoVO vo) throws Exception;	
		
}


