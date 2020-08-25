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
		UserEntity user = ur.findByUserName(username)
				.orElseThrow(()->new IllegalArgumentException("존재하지 않는 유저입니다"));

		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
		
		if (user.getRole().equals("0"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.ADMIN.getValue()));
		else if (!user.getRole().equals("1"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.MEMBER.getValue()));
		else if (!user.getRole().equals("2"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.GITHUB.getValue()));
		else if (!user.getRole().equals("4"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.GOOGLE.getValue()));
		else if (!user.getRole().equals("5"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.NAVER.getValue()));
		else if (!user.getRole().equals("6"))
			grantedAuthorities.add(new SimpleGrantedAuthority(SocialType.KAKAO.getValue()));
	
		return	new User(user.getUserName(), user.getUserPassword(), grantedAuthorities);	
		
	}
}		
	

