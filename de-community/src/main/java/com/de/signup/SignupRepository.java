package com.de.signup;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.de.user.Users;
import com.de.user.UsersDetail;

@Repository
public interface SignupRepository extends JpaRepository<Users, String>{
	List<Users> findAll();
	List<Users> findAllByUserEmail(String userEmail);
	boolean existsByUserEmail(String userEmail);

}

