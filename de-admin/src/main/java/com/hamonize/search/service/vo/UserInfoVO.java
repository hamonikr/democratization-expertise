package com.hamonize.search.service.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserInfoVO {

    private int seq;
    private String bizcd;
    private int bizno;
    private String user_id;// 관리자 아이디
    private String user_nm;// 관리자 이름
    private String user_passwd; //관리자 비밀번호
    private String user_email;// 관리자 이메일
    private String active_status; //활성화 여부 
    private String proc_stat; //회원가입 승인 여부 
    private int delete_at; //계정 삭제 여부 (0 : 삭제 안됨 / 1 : 삭제 됨)
   
}
