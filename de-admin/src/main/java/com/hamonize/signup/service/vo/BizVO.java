package com.hamonize.signup.service.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BizVO {

    private String bizcd; // 회사 코드
    private String biznm; // 회사명
    private String biznm_en; // 회사 영문명
    private String biztype; // 업종
    private String bizkind; // 업태
    private String bizno; // 사업자번호
    private String rprsnt_nm; // 대표명
    private String addr1; // 회사 주소
    private String addr2; // 회사 상세주소
    private String tele; // 회사 번호
    private String fax; // 회사 팩스
    private String biz_auth_role; // 회사 권한
    private Date updt_date;// 회사 수정

}
