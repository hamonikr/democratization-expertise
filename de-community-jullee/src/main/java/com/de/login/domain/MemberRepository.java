package com.de.login.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<MemberEntity,String> {
    Optional<MemberEntity> findByUserid(String userid);
}