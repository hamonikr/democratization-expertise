<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="content-center">
	<h2>로그인</h2>
	
	<div class="con-box">


	<form id="frm" name="frm" method="post" autocomplete="off" style="width: 95%;">
		<input type="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}" />
            <div class="login bg1">
              <ul class="login-in">
                <li>회원구분
                  <label class="control control-radio">개인
                    <input type="radio" name="radio" id="1">
                    <div class="control-indicator"></div>
                  </label>
                  <label class="control control-radio">기업
                    <input type="radio" name="radio" id="2">
                    <div class="control-indicator"></div>
                  </label>
                </li>
                <li><label>아이디</label><input type="text" id="username" name="username" value="ryan" placeholder="아이디를 입력해주세요" maxlength="20" class="input-type1"></li>
                <li><label>비밀번호</label><input type="password" id="password" name="password" value="exitem0*" placeholder="비밀번호를 입력해주세요" maxlength="20" class="input-type1"></li>
                <li><button type="submit" class="btn-blue">로그인</button></li>
              </ul>
              <ul class="login-in2">
                <li><a href="/accountRecovery/sendRecoveryEmail"><i class="mdi mdi-lock-open"></i>비밀번호 찾기</a></li>
                <li><a href="/signup/signup"><i class="mdi mdi-account-plus"></i>회원가입</a></li>
              </ul>

              <div class="mT20 mB10">- SNS 계정으로 로그인하기 -</div>
              <ul class="login-in3">
                <li><a href="#"><img src="/img/join_kakao.png" alt="kakao"></a></li>
                <li><a href="/login/google" class="btn_social"> <img src="/img/join_google.png" alt="google"></a></li>
                <li><a href="#"><img src="/img/join_naver.png" alt="naver"></a></li>
                <li><a href="/login/github" class="btn_social" data-social="github"><img src="/img/join_github.png" alt="github"></a></li>
              </ul>
            </div>
</form>
          </div>

</div>
<!-- 깃헙 -->
<!-- <div class="col-2">
	<a href="/login/github" class="btn_social" data-social="github"> <img src="/img/google-plus.png" style="height: 30px; margin-left: 0px;"></a>
</div> -->

<!-- 구글 -->
<!-- <div class="col-2" style="margin-left: 20px;">
	<a href="/login/google" class="btn_social"> <img src="/img/google-plus.png" style="height: 30px;"></a>
</div> -->

<!-- 네이버 -->
<!-- <div class="col-2" style="margin-left:20px;">	        	
       	<a href="javascript:;" class="btn_social" data-social="naver">
				<img src="/img/naver_login.png" style="height:30px;">
			</a>		
        </div>
        
        카카오
        <div class="col-2" style="margin-left:20px;">
	      <a href="javascript:;" class="btn_social" data-social="kakao">
			<img src="/img/kakaolink_btn_medium_ov.png" style="height:30px;">	
			</a>
        </div> -->




<script type="text/javascript">
	// 일반 로그인 
 	let socials = document.getElementsByClassName("btn_social"); 

   for(let social of socials) {
		social.addEventListener('click', function(){ 
			let socialType = this.getAttribute('data-social'); 
    		location.href="/oauth2/authorization/" + socialType; 
    	})
	}


   

  </script>

