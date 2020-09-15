package com.de.wiki;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WikiRepository extends JpaRepository<Wiki, Integer>{
	List<Wiki> findAllBySection(String section);

}
