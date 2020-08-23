package com.de.user.mapper;

import java.util.List;

import com.de.enterprise.Enterprises;
import com.de.user.UserPwVO;
import com.de.user.Users;

public interface UsersMapper {
	public int updateUserPw(UserPwVO vo);
	public List<Enterprises> getEnterList(String enterName);
	public void updateUserProfileImg(Users vo);
}