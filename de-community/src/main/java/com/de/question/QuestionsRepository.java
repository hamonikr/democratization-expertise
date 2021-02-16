package com.de.question;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface QuestionsRepository extends JpaRepository<Questions, Integer> {

	Page<Questions> findAllByDeleteat(int deleteat, Pageable pageable);

	Page<Questions> findAllByFirstuserno(int seq, Pageable pageable);

	Page<Questions> findAllByFirstusernoAndDeleteat(int seq, int deleteat, Pageable pageable);
}