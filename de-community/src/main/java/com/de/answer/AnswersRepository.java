package com.de.answer;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnswersRepository extends JpaRepository<Answers, Integer>{
	//Page<Answers> findAllByDeleteat(int deleteat, Pageable pageable);
	
	List<Answers> findAllByquestionno(int questionno);

}
