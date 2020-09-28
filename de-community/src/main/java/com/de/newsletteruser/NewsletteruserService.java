package com.de.newsletteruser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.newsletteruser.mapper.NewsletteruserMapper;

@Service
public class NewsletteruserService {
	@Autowired
	NewsletteruserMapper mapper;
	
	public int saveSubscriber(MailingUserList vo) throws Exception{		
		return mapper.saveSubscriber(vo);
	}
	
	public int checkDuplication(MailingUserList vo) throws Exception{		
		return mapper.checkDuplication(vo);
	}

}
