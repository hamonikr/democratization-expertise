<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

 <!-- jquery-validation -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 


<div class="content-center">
	
	<div class="con-box" style="height:100%">


	<form id="frm" name="frm" method="post" autocomplete="off" style="width: 95%;">
		<input type="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}" />
            <div class="login bg1">
              <ul class="login-in">
<!--                 <li>회원구분 -->
<!--                   <label class="control control-radio">개인 -->
<!--                     <input type="radio" name="radio" id="1"> -->
<!--                     <div class="control-indicator"></div> -->
<!--                   </label> -->
<!--                   <label class="control control-radio">기업 -->
<!--                     <input type="radio" name="radio" id="2"> -->
<!--                     <div class="control-indicator"></div> -->
<!--                   </label> -->
<!--                 </li> -->
                <li><label>아이디</label><div class="form-group"><input type="text" id="username" name="username" value="" placeholder="아이디를 입력해주세요" maxlength="20" class="input-type1"></div></li>
                <li><label>비밀번호</label><div class="form-group"><input type="password" id="password" name="password" value="" placeholder="비밀번호를 입력해주세요" maxlength="20" class="input-type1"></div></li>
                <li><button type="submit" class="btn-blue">로그인</button></li>
              </ul>
              <ul class="login-in2">
                <li><a href="/accountRecovery/sendRecoveryEmail"><i class="mdi mdi-lock-open"></i>비밀번호 찾기</a></li>
                <li><a href="/signup/signup"><i class="mdi mdi-account-plus"></i>회원가입</a></li>
              </ul>

              <div class="mT20 mB10">- SNS 계정으로 로그인하기 -</div>
              <ul class="login-in3">
<!--                 <li><a href="#"><img src="/img/join_kakao.png" alt="kakao"></a></li> -->
                <li><a href="/login/form/web" class="btn_social"> <img src="/img/join_google.png" alt="google"></a></li>
                <li><a href="/login/form/app" class="btn_social"> <img src="/img/join_google.png" alt="google"></a></li>
<!--                 <li><a href="#"><img src="/img/join_naver.png" alt="naver"></a></li> -->
                <li><a href="/login/github" class="btn_social" data-social="github"><img src="/img/join_github.png" alt="github"></a></li>
              </ul>
            </div>
</form>
          </div>

</div>


<script type="text/javascript">
	// 일반 로그인 
 	let socials = document.getElementsByClassName("btn_social"); 
   for(let social of socials) {
		social.addEventListener('click', function(){ 
			let socialType = this.getAttribute('data-social'); 
    		location.href="/oauth2/authorization/" + socialType; 
    	})
	}
   $(document).ready(function() {
   
   $('#frm').validate({
		 rules: {
			 username:{ required: true },
			 password:{ required: true}			     
		  }, 
		  messages:{
			  username:{
		 			required : "아이디를 입력해주세요.",
		 		},
		 		password:{
		 			required : "비밀번호를 입력해주세요.",
		 		}
		 	 },
		    errorElement: 'span',
		    errorPlacement: function (error, element) {
		   	  		error.addClass('invalid-feedback');
		       	element.closest('.form-group').append(error);
		 	},
		 	highlight: function (element, errorClass, validClass) {
		 	        $(element).addClass('is-invalid');
		 	},
		 	unhighlight: function (element, errorClass, validClass) {
		 	   	     $(element).removeClass('is-invalid');
		 	},
		 	submitHandler: function (frm) {
					document.frm.submit();
			 	
			 	}
   		});
   });
  
	 
  </script>