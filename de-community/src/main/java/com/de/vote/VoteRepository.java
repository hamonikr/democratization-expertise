package com.de.vote;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoteRepository extends JpaRepository<Vote, Integer>{
	
	//Page<Vote> findAllBySection(String section, Pageable pageable);

}
