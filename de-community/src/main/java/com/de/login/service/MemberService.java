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
//		// TODO Auto-generated method stub
//		Users vo = new Users();//		try {
//////			List<Users> lvo = sr.findByUserId(userId);
//////			Users vo = lvo.get(0);
//////			System.out.println("--->" + lvo.toString());
////			
////			vo.setUserName(username);
////			List <Users> lvo = lr.findByUserId(username);
////			for(int i=0;i<lvo.size();i++){
////				System.out.println("list vo---> "+lvo.get(i).toString());
////			}
//////			System.out.println("lr--->" + vo.toString());
////			
////			return new SecurityMember(vo);
////		} catch (Exception e) {
////			// TODO Auto-generated catch block
////			System.out.println("///username?" + username);
////			List <Users> lvo = lr.findByUserId(username);
////			for(int i=0;i<lvo.size();i++){
////				System.out.println("list vo---> "+lvo.get(i).getUserPassword());
////				vo.setUserPassword(lvo.get(i).getUserPassword());
////				vo.setUserId(lvo.get(i).getUserId());
////			}		
////			System.out.println("---> fail loadUserByUsername ");
////			e.printStackTrace();
////			
////			return new SecurityMember(vo);	
//	
//		
//		System.out.println("///username?" + username);
//		List <Users> lvo = lr.findByUserId(username);
//		for(int i=0;i<lvo.size();i++){
//			System.out.println("list vo---> "+lvo.get(i).getUserPassword());
//			vo.setUserPassword(lvo.get(i).getUserPassword());
//			vo.setUserId(lvo.get(i).getUserId());
//		}		
//	
//		Collection<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
//		roles.add(new SimpleGrantedAuthority("ROLE_USER"));
//		
//		//User userDetails = new User(vo.getUserId(), vo.getUserPassword(), roles);
//	
//		return new SecurityMember(vo);
		Login vo = lr.findByUserId(username);		
//		Users vo = null;
//		vo.setUserId(lvo.getUserId());
//		vo.setUserPassword(lvo.getUserPassword());
//		vo.setUserEmail(lvo.getUserEmail());
//		vo.setUserName(lvo.getUserName());
//		vo.setUserEmail(lvo.getUserEmail());
		
		if (vo == null) { 
				throw new UsernameNotFoundException(username);
			} else {
		System.out.println("Member service vo -->" + vo.toString());
			return new SecurityMember(vo);		
		}
	}
		
}
