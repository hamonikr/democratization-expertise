package com.de.enterprise;


import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface EnterprisesRepository extends JpaRepository<Enterprises, Integer> {

	@Override
	Page<Enterprises> findAll(Pageable pageable);

	Optional<Enterprises> findByEnterpriseno(int seq);

}