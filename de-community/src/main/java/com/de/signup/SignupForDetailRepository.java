package com.de.signup;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.de.user.Users;
import com.de.user.UsersDetail;

@Repository
public interface SignupForDetailRepository extends JpaRepository<UsersDetail, Integer>{
	List<UsersDetail> findAll();
   List<UsersDetail> findByEnterpriseno(Integer enterpriseno);
   
}
