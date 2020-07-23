package com.de.login.service;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.de.login.Login;
import com.de.user.Users;
import com.de.user.UsersDetail;

@Repository
public interface LoginRepository extends JpaRepository<Login, String>{

//	@Query(value = "select * from tb_users a where a.user_id = %?1%", nativeQuery = true)
//   Users findByUserId(String userId);
	
   // List<Users> findByUserId(String userId);
    List<Login> findByUserPassword(String userPassword);
 
    Login findByUserId(String username);
    
 //   List<Login> findByEmailAndUserId(String userEmail, String userId);
    Login findByUserEmailAndUserId(String userEmail, String userId);
    
    boolean existsByUserId(String userId);
}

