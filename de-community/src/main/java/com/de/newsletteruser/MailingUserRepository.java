package com.de.newsletteruser;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MailingUserRepository extends JpaRepository<MailingUserList, Integer>{

}