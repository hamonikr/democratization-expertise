package com.de.security;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, String>{

		Optional<UserEntity> findByUsername(String username);
		Optional<UserEntity> findByUseremail(String email);

}
