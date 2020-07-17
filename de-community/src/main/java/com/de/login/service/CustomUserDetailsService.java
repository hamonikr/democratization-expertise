package com.de.login.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.de.signup.SignupRepository;
import com.de.user.Users;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	SignupRepository sr;

	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		try {
//			List<Users> lvo = sr.findByUserId(userId);
//			Users vo = lvo.get(0);
//			System.out.println("--->" + lvo.toString());
			Users vo = null;
			vo.setUserId("test");
			vo.setUserPassword("1234");
			System.out.println("id---->" + vo.getUserId());
			System.out.println("pw---->" + vo.getUserPassword());

			return new SecurityMember(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("---> fail loadUserByUsername ");
			e.printStackTrace();
		}
		return null;
	}

}
