package com.hamonize.signup.service.mapper;

import java.util.List;
import com.hamonize.signup.service.vo.CompanyVO;
import com.hamonize.signup.service.vo.UserMngrVO;

public interface SignupMapper {

    /*저장 */
	// 회사 정보 저장
    public int bizInfoSave(CompanyVO vo) throws Exception;

    // 담당자 정보 저장
    public int userInfoSave(CompanyVO vo) throws Exception;
    
    
    /* 중복체크  */
    // 사업자 번호 체크
    public int biznoCheck(CompanyVO vo) throws Exception;

    // 아이디 중복 체크
    public int userIDCheck(CompanyVO vo) throws Exception;

    // 추가 담당자 아이디 중복 체크
    public int addUserIDCheck(CompanyVO vo) throws Exception;

    
    /* 불러오기 */
    // 회원정보 수정 페이지에서 회사정보 불러오기
    public CompanyVO getBizInfo(CompanyVO vo) throws Exception;

    // 회원정보 수정 페이지에서 유저 정보 불러오기
    public UserMngrVO getUserInfo(UserMngrVO vo) throws Exception;

    // 회원정보 수정 페이지에서 추가 유저 정보 불러오기
    public List<UserMngrVO> getAddUserInfo(UserMngrVO vo) throws Exception;
  
    // 유저의 권한정보 불러오기
    public CompanyVO getUserRole(CompanyVO vo) throws Exception;
    
    
    /* 수정하기 */    
    // 회원정보 수정 페이지에서 회사 정보 수정할 때
    public int bizInfoUpdate(CompanyVO vo) throws Exception;

    // 대표 or 추가 담당자 정보 수정할 때  
    public int userInfoUpdate(UserMngrVO vo) throws Exception;
  
    // 회원정보 수정 페이지에서 정보 수정할 때 비밀번호 제외하고 
    public int userInfoUpdate_without_pw(UserMngrVO vo) throws Exception;
    
    // 추가 담당자 활성여부 변경 
    public int updateUserActiveStatus(UserMngrVO vo) throws Exception;
    
    
    
    /* 삭제하기 */    
    // 추가 담당자 정보 삭제할 때  
    public int deleteAddUserInfo(UserMngrVO vo) throws Exception;

}
