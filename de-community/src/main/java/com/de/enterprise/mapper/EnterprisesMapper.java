package com.de.enterprise.mapper;

import java.util.List;

import com.de.enterprise.EnterprisePwVO;
import com.de.enterprise.Enterprises;
import com.de.user.Users;
import com.de.user.UsersDetail;

public interface EnterprisesMapper {
	public int updateEnterprisePw(EnterprisePwVO vo);
	public void updateEnterprisesimg(Enterprises vo);
	public List<Users> getMembersList(UsersDetail vo);
	public List<Users> getActiveatMembersList(UsersDetail vo);
	public boolean updateActivaet(UsersDetail vo);
	public boolean updateUserat(UsersDetail vo);
}