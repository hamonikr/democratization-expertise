package com.de.findAccount;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class Account {

    private String userid;// 관리자 아이디
    private String userpassword; //관리자 비밀번호
    private String useremail;// 관리자 이메일
    private int activeat; //활성화 여부 
   
}
