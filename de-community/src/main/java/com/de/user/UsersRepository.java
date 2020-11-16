package com.de.user;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersRepository extends JpaRepository<Users, Integer>{
	Page<Users> findAll(Pageable pageable);
	
	//@Query("select * from tb_users a join fetch a.usersDetail")
	
	Optional<Users> findByUserno(int seq);

}