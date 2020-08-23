package com.de.user.mapper;

import java.util.List;
import java.util.Optional;

import com.de.enterprise.Enterprises;
import com.de.user.UserPwVO;
import com.de.user.Users;
import com.de.user.UsersDetail;

public interface UsersMapper {
	public Optional<Enterprises> findEnterpriseNo(int seq);
	public int updateUserPw(UserPwVO vo);
	public void updateUserProfileImg(Users vo);
	public List<Enterprises> getEnterList(Enterprises vo);
	public void updateEnterpriseNo(UsersDetail vo);
}