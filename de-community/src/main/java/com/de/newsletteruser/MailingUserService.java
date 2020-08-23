package com.de.newsletteruser;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.newsletteruser.mapper.MailingUserMapper;


@Service
@Transactional
public class MailingUserService {
	
	@Autowired
	MailingUserRepository mr;
	
	@Autowired
	MailingUserMapper mm;

//	public Optional<MailingUserList> findById(int seq) throws Exception {
//		return mr.findById(seq);
//	}
}