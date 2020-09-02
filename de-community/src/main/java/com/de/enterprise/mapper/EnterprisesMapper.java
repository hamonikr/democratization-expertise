package com.de.enterprise.mapper;

import java.util.List;

import com.de.enterprise.EnterprisePwVO;
import com.de.enterprise.Enterprises;
import com.de.user.Users;

public interface EnterprisesMapper {
	public int updateEnterprisePw(EnterprisePwVO vo);
	public void updateEnterprisesimg(Enterprises vo);
	public List<Users> getMembersList(int seq);
}