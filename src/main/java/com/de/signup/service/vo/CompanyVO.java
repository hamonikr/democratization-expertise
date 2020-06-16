package com.de.signup.service.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CompanyVO {

    private int seq; // 회사 고유번호
    private String bizcd; // 회사 코드
    private String biznm; // 회사명
    private String biznm_en; // 회사 영문명
    private String biztype; // 업종
    private String bizkind; // 업태
    
    private String bizno; // 사업자번호
    private String bizno1;
    private String bizno2;
    private String bizno3;
    
    private String rprsnt_nm; // 대표명
    
    private String addr1; // 회사 주소
    private String addr2; // 회사 상세주소

    private String tele; // 회사 번호
    private String tele1; 
    private String tele2;
    private String tele3;
    
    private String fax; // 회사 팩스
    private String fax1;
    private String fax2;
    private String fax3;
    
    private String biz_auth_role; // 회사 권한
    private String proc_stat; // 승인 요청상태 코드
    private Date reg_date1; // 회사 가입일
    private Date updt_date1;// 회사 수정

    private String user_id;// 관리자 아이디
    private String user_passwd1;// 관리자 pw
    private String user_role;// 관리자 pw
    
    private String user_nm;// 관리자 이름
    private String user_ip;// 관리자 유저 ip
    private String user_email;// 관리자 이메일

    private String user_hp; // 관리자 번호
    private String user_hp1; // 관리자 번호
    private String user_hp2; // 관리자 번호
    private String user_hp3; // 관리자 번호

    
    private String user_rank;// 관리자 직급
    private String user_dept;// 관리자 부서
    private Date reg_date2; // 관리자 가입일
    private Date updt_date2; // 관리자 수정일

}
