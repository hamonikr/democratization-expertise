package com.de.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.de.login.mapper.LoginMapper;
import com.de.login.vo.LoginVO;

@Service
public class MemberService implements UserDetailsService {

	@Autowired
	LoginMapper lMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	try {
    			LoginVO vo = lMapper.getUser(username);
			return new SecurityMember(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
			return null;

    	
    }
}
