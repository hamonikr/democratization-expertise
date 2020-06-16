package com.de.signup.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.signup.service.mapper.SignupMapper;
import com.de.signup.service.vo.CompanyVO;
import com.de.signup.service.vo.UserMngrVO;



@Service
@Transactional
public class SignupService {


	@Autowired
    SignupMapper signupMapper;

	/* 저장 */
	
	// 회원가입시 회사정보 저장
    @Transactional
    public int bizInfoSave(CompanyVO vo) throws Exception {
        SimpleDateFormat date_format = new SimpleDateFormat("yyMM");
        Calendar time = Calendar.getInstance();
        String dateTemp = date_format.format(time.getTime());

        vo.setBizno(vo.getBizno1() + vo.getBizno2() + vo.getBizno3());
        vo.setBizcd(vo.getBiznm_en().substring(0, 3) + vo.getBizno3() + dateTemp);
               
        vo.setTele(vo.getTele1()+vo.getTele2()+vo.getTele3());
        vo.setFax(vo.getFax1()+vo.getFax2()+vo.getFax3());

        return signupMapper.bizInfoSave(vo);
    }
    
    

    // 유저정보 저장
    public int userInfoSave(CompanyVO vo) throws Exception {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        vo.setUser_passwd1(passwordEncoder.encode(vo.getUser_passwd1()));
        vo.setUser_hp(vo.getUser_hp1()+vo.getUser_hp2()+vo.getUser_hp3());
        
        return signupMapper.userInfoSave(vo);
    }

    // 추가 유저정보 저장
    public Integer addUserInfoSave(CompanyVO vo) throws Exception {
         //입력된 비밀번호 암호화 처리
         BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
         vo.setUser_passwd1(passwordEncoder.encode(vo.getUser_passwd1()));
          
        Integer aaa = 0;

        try {
            aaa = signupMapper.userInfoSave(vo);
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("qury exception 발생 ! ====> " + e.getMessage());
            aaa = 4444;
        }

        return aaa;
    }

    /* 중복 체크 */    
    // 사업자번호 체크
    public int biznoCheck(CompanyVO vo) throws Exception {   	
        return signupMapper.biznoCheck(vo);
    }

    // 아이디 중복 체크
    public int userIDCheck(CompanyVO vo) throws Exception {
        return signupMapper.userIDCheck(vo);
    }

    // 추가담당 아이디 정보 체크
    public int addUserIDCheck(CompanyVO vo) throws Exception {
        return signupMapper.addUserIDCheck(vo);
    }

    /* 불러오기 */
    
    // 회원정보 수정 페이지에서 회사정보 불러오기
    public CompanyVO getBizInfo(CompanyVO vo) throws Exception {	
	return signupMapper.getBizInfo(vo);
    }

    // 회원정보 수정 페이지에서 유저정보 불러오기
    public UserMngrVO getUserInfo(UserMngrVO vo) throws Exception {
        return signupMapper.getUserInfo(vo);
    }

    // 회원정보 수정 페이지에서 추가 유저정보 불러오기
    public List<UserMngrVO> getAddUserInfo(UserMngrVO vo) throws Exception {
        return signupMapper.getAddUserInfo(vo);
    }
    // 유저의 권한정보 불러오기
    public CompanyVO getUserRole(CompanyVO vo) throws Exception {
        return signupMapper.getUserRole(vo);
    }
    
    /* 수정 */
    
    // 회원정보 수정 페이지에서 정보 수정할 때
    public int bizInfoUpdate(CompanyVO vo) throws Exception {
        
	vo.setTele(vo.getTele1()+vo.getTele2()+vo.getTele3());
	vo.setFax(vo.getFax1()+vo.getFax2()+vo.getFax3());

        return signupMapper.bizInfoUpdate(vo);
    }
    
    
    // 회원정보 수정 페이지에서 정보 수정할 때
    public int userInfoUpdate(UserMngrVO vo) throws Exception {
    	if(vo.getUser_passwd() != "") {
         BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
         vo.setUser_passwd(passwordEncoder.encode(vo.getUser_passwd()));
         vo.setUser_hp(vo.getUser_hp1()+vo.getUser_hp2()+vo.getUser_hp3());

    }
        return signupMapper.userInfoUpdate(vo);
    }

    // 회원정보 수정시 비밀번호 제외하고 
    public int userInfoUpdate_without_pw(UserMngrVO vo) throws Exception {
        vo.setUser_hp(vo.getUser_hp1()+vo.getUser_hp2()+vo.getUser_hp3());
        return signupMapper.userInfoUpdate_without_pw(vo);
    }    
    
    // 추가 담당자 활성여부 변경 
    public int updateUserActiveStatus(UserMngrVO vo) throws Exception{ 	   	
    	 return signupMapper.updateUserActiveStatus(vo);
    }
    
    /* 삭제 */
    // 회원정보 수정 페이지에서 정보 삭제할 때
    public int deleteAddUserInfo(UserMngrVO vo) throws Exception {
     
        return signupMapper.deleteAddUserInfo(vo);
    }
}