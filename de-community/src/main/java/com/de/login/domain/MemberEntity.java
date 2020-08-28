package com.de.login.domain;

import javax.persistence.*;
import lombok.AccessLevel;
import lombok.*;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@Entity
@Table(name = "tb_users")
public class MemberEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private String userid;

    @Column(length = 20, nullable = false)
    private String useremail;

    @Column(length = 100, nullable = false)
    private String userpassword;

    @Builder
    public MemberEntity(String userid, String useremail, String userpassword) {
        this.userid = userid;
        this.useremail = useremail;
        this.userpassword = userpassword;
    }
}
