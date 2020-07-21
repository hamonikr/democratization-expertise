package com.de.login.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.signup.SignupRepository;
import com.de.user.Users;
import com.de.login.Login;
import com.de.login.service.SecurityMember;
import org.springframework.security.core.GrantedAuthority;

@Service
public class MemberService implements UserDetailsService{
	
	@Autowired
	LoginRepository lr;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Login vo = lr.findByUserId(username);		

		if (vo == null) { 
				throw new UsernameNotFoundException(username);
			} else {
		System.out.println("Member service vo -->" + vo.toString());
			return new SecurityMember(vo);		
		}
	}		
}
