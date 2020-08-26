package com.de.security.service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.de.security.SocialType;
import com.de.security.UserEntity;
import com.de.security.UserRepository;

@Service
public class MemberService implements UserDetailsService{
	
	@Autowired
	private UserRepository ur;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserEntity user = ur.findByUsername(username).orElseThrow(()->new IllegalArgumentException("존재하지 않는 유저입니다"));
		return new User(user.getUsername(), user.getUserpassword(), Arrays.asList(new SimpleGrantedAuthority(user.getRole())));
		}
	}		

