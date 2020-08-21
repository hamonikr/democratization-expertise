package com.de.findAccount;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Account {

    private String user_id;// 관리자 아이디
    private String user_password; //관리자 비밀번호
    private String user_email;// 관리자 이메일
    private int active_at; //활성화 여부 
   
}
