package com.de.findAccount;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class Account {

    private String userid;// 유저 아이디
    private String username; // 유저 이름(닉네임)
    private String userpassword; //유저 비밀번호
    private String useremail;// 유저 이메일
    private int activeat; // 계정 활성화 여부 
   
}
