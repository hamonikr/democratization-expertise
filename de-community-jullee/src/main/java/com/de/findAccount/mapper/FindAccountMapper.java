package com.de.findAccount.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.de.findAccount.Account;

@Mapper
public interface FindAccountMapper {
	
	public Account isExistAccount(Account vo)throws Exception;
	
	public int resetUserPw(Account vo) throws Exception;

}
