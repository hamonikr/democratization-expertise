package com.de.user;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface UsersListRepository extends JpaRepository<Userslist, Integer> {

	@Query(value = ""
			+ "select   c.score as userscore, e.userno,e.username, e.userurl, e.userid, e.picture, e.userprofileimg,  "
			+ "case when d.tot != 0 then d.tot else 0 end as totlikes from    tb_users e\n" + "      LEFT JOIN ("
			+ "        select  userno  , (sum(likes) - sum(dislikes) ) as tot from  tb_vote"
			+ "        group by userno ) d  on e.userno = d.userno "
			+ "LEFT JOIN (select userno, score  from tb_score ) c on e.userno = c.userno"

			, countQuery = "" + "select   count(*)from tb_users"

			, nativeQuery = true)
	Page<Userslist> findAllWithTeacher(Pageable pageable);

}
