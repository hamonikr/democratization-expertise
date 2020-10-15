package com.hamonize.search.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hamonize.search.service.mapper.SearchMapper;
import com.hamonize.search.service.vo.UserInfoVO;

@Service
@Transactional
public class SearchService {

	@Autowired
	SearchMapper mapper;
	
	public UserInfoVO findUserInfo(UserInfoVO vo) throws Exception{
		return mapper.findUserInfo(vo);
	}	
	
	public String findBizcd(UserInfoVO vo) throws Exception{
		return mapper.findBizcd(vo);
	}
	
	
	public int resetUserPw(UserInfoVO vo) throws Exception{
		//비밀번호 인코딩
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
       vo.setUser_passwd(passwordEncoder.encode(vo.getUser_passwd()));
    
		return mapper.resetUserPw(vo);
	}
	
	public int checkUserID(UserInfoVO vo) throws Exception{
	    return mapper.checkUserID(vo);
	}

	
}
