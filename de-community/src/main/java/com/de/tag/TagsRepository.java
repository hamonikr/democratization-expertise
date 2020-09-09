package com.de.tag;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TagsRepository extends JpaRepository<Tags, Integer>{
	//Page<Questions> findAllByDeleteAt(int deleteAt, Pageable pageable);

}
