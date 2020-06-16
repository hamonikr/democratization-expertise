package com.de.search.web;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.de.search.service.SearchService;
import com.de.search.service.vo.UserInfoVO;
import com.de.search.service.PostMail;

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	private  SearchService service;

	// 아이디 찾기 동작
	@RequestMapping(value = "/searchId.proc")
	@ResponseBody
	public String searchId(HttpServletRequest request, UserInfoVO vo, ModelMap model) throws Exception {
		String result="aaa";
		
		System.out.println("아이디 찾기 조회 확인");		
		System.out.println("전달 받은 값 확인" + vo.getUser_nm()+ " "+ vo.getBizno()+" "+vo.getUser_email());
		
		vo.setBizcd(service.findBizcd(vo));
		
		if (vo.getBizcd() != null) {			
			System.out.println("bizcd ===> " + vo.getBizcd());
			if((vo = service.findUserInfo(vo))!=null) {	
			    System.out.println("user_id ===>" + vo.getUser_id());
			
			    result = vo.getUser_id();
			}else {
			    System.out.println("아이디 가져오기 실패");
			    result="searched_fail";
			}
		} else {
			System.out.println("bizcd 가져오기 실패!");
			result ="biz_problem";	
		}
		
		return result;		
	}

	// 비밀번호 찾기 동작
		@RequestMapping(value = "/searchPw.proc")
		@ResponseBody
		public int searchPw(HttpServletRequest request, UserInfoVO vo, ModelMap model) throws Exception {
			int up_result=0;
			PostMail sendMail = new PostMail();
			System.out.println("패스워드 찾기 조회 확인");		
			System.out.println("뷰에서 전달 받은 값 확인"+"유저 아이디 ==>" + vo.getUser_id() +"\n"+"유저 이름 ==>"+ vo.getUser_nm());
			System.out.println("user_email ===>" + vo.getUser_email());
			

			StringBuffer tmpRnd = new StringBuffer();
			Random rnd = new Random();
			
			
			if(service.checkUserID(vo) ==1) {
			    System.out.println("비밀번호 조회/변경 성공!");
				for (int i = 0; i < 5; i++) {
				    int rIndex = rnd.nextInt(3);
				    switch (rIndex) {
				    case 0:
				        // a-z
				    	tmpRnd.append((char) ((int) (rnd.nextInt(26)) + 97));
				        break;
				    case 1:
				        // A-Z
				    	tmpRnd.append((char) ((int) (rnd.nextInt(26)) + 65));
				        break;
				    case 2:
				        // 0-9
				    	tmpRnd.append((rnd.nextInt(10)));
				        break;
				    }
				}
				// 버퍼에있는 값 String으로 변경
				String rndPw = tmpRnd.toString();		
				vo.setUser_passwd(rndPw);
			
				
				System.out.println("비밀번호 초기화 성공 ===> "+vo.getUser_passwd());
				sendMail.inviteMail(vo);	
				
				up_result = service.resetUserPw(vo);
				return up_result;

			} else {
			    System.out.println("비밀번호 조회/변경 실패!");
			    }
					
			return up_result;
		
		}	
}


