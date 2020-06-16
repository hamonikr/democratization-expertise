package com.de.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.de.login.service.mapper.LoginMapper;
import com.de.user.service.UserVO;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	LoginMapper lMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		try {
			UserVO vo = lMapper.getUser(username);
			return new SecurityMember(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
