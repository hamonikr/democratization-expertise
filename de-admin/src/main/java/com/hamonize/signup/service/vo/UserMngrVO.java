package com.hamonize.signup.service.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserMngrVO {

    private int seq;
    private String bizcd;
    private String user_id;// 관리자 아이디
    private String user_nm;// 관리자 이름
    private String user_passwd; //관리자 비밀번호
    private String user_role; // 관리자 권한 구분
    private String user_rank;// 관리자 직급
    private String user_dept;// 관리자 부서
    private String user_hp; // 관리자 번호
    private String user_hp1; // 관리자 번호
    private String user_hp2; // 관리자 번호
    private String user_hp3; // 관리자 번호

    private String user_email;// 관리자 이메일
    private Date updt_date; // 관리자 수정일
    private String active_status; //활성화 여부 
    private String proc_stat; //회원가입 승인 여부 
    private int delete_at; //계정 삭제 여부 (0 : 삭제 안됨 / 1 : 삭제 됨)
   
}
