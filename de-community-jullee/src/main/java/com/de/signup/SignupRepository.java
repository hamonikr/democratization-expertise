package com.de.signup;


import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.de.user.Users;

@Repository
public interface SignupRepository extends JpaRepository<Users, String>{
	List<Users> findAllByUseremail(String userEmail);
	boolean existsByUseremail(String userEmail);
    List<Users> findByUserid(String userId);
    List<Users> findByUseremail(String userEmail);

}

