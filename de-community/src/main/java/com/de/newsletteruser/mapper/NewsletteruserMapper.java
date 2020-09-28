package com.de.newsletteruser.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.de.newsletteruser.MailingUserList;


@Mapper
public interface NewsletteruserMapper {
	public int saveSubscriber (MailingUserList vo) throws Exception;
	public int checkDuplication(MailingUserList vo) throws Exception;	
}
