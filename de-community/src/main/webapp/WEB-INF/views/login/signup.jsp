<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


  <!-- jquery-validation -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 

  <!-- google reecaptcha 추가 --> 
  <script src='https://www.google.com/recaptcha/api.js'></script>
  <script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
  <meta name="google-signin-scope" content="profile email">
  <meta name="google-signin-client_id" content="1042506284094-s49av9n5sk34ell2u70lachpmihn07gu.apps.googleusercontent.com"></meta>





<div class="content-center">

 
	<div class="con-box" style="height:100%">
	<form id ="frm" name="frm" method="post">      
   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="login bg2">
        	<div class="join-info">
            	<font class="blue bold">ASKOS에 가입하시면,</font> 질문을 통해 궁금했던 정보를 얻고 투표와 답변을 통해 새로운 권한을 부여받고 관심있는 태그와 위키문서를 저장할 수 있습니다.
			</div>
            
            <ul class="user-tab">
            	<li><a href="/signup/signup" class="current">일반회원 가입</a></li>
                <li><a href="/signup/partnerSignup">파트너사 가입</a></li>
			</ul>
            <ul class="login-in">
            	<li><label>아이디</label><div class="form-group"><input type="text"  id="userid" name="userid" maxlength="20"  placeholder="아이디를 입력해주세요" class="input-type1"></div></li>
                <li><label>이름</label><div class="form-group"><input type="text" id="username" value="" name="username" maxlength="30" placeholder="이름을 입력해주세요"class="input-type1"></div></li>
                <li><label>E-mail 주소</label><div class="form-group"><input type="text" id="useremail" value="" name="useremail"  placeholder="이메일을 입력해주세요" class="input-type1"></div></li>
                <li><label>비밀번호</label><div class="form-group"><input type="password" id="userpassword" value="" name="userpassword"  placeholder="비밀번호를 입력해주세요"class="input-type1"></div></li>
                <li><label>비밀번호확인</label><div class="form-group"><input type="password" name="userpassword2" id="userpassword2" class="input-type1"><font id="passDubChk" size="1"></font>
                </div></li>
                <li><div class="g-recaptcha" data-sitekey="6LeS16wZAAAAADQYkYoSCaRt5wIb0YBSGGnnqVdH"></div></li>
                <li><input type="submit" id="create_account" value="계정 생성하기" class="btn-blue"></li>
			</ul>

<!--             <div class="mT20 mB10">- SNS 계정으로 회원가입하기 -</div> -->
<!--             	<ul class="login-in3"> -->
<!--                 	<li><a href="#"><img src="../img/join_kakao.png" alt="kakao"></a></li> -->
<!--                   	<li><a href="#"><img src="../img/join_google.png" alt="google"></a></li> -->
<!--                   	<li><a href="#"><img src="../img/join_naver.png" alt="naver"></a></li> -->
<!--                   	<li><a href="#"><img src="../img/join_github.png" alt="github"></a></li> -->
<!-- 				</ul> -->
			</div>
	</form>
    </div>
</div>
     

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 

 $(document).ready(function() {
	// 비밀번호는 영문+숫자 조합으로
	 $.validator.addMethod("passwordCk",  function( value, element ) {
		   return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z]).*$/.test(value);
		});

	
	 $('#frm').validate({
		 rules: {
		 	  userid:{ required: true, minlength: 3 },
		 	  username:{ required: true, minlength: 1 },
		 	  useremail:{ required: true, email: true },
		     userpassword:{ required: true, minlength:6, passwordCk : true }
			     
		  }, 
		  messages:{
		 		userid:{
		 			required : "아이디를 입력하시오.",
		 			minlength : "최소 {0}자 입력해주세요"
		 		},
		 		username:{
		 			required : "이름을 입력하시오.",
		 			minlength : "최소 {0}자 입력해주세요"
		 		},									
		 	   useremail: {
		 			required : "이메일은 필수값 입니다.",
		 			email : "이메일 형식을 확인해주세요"
		 			},
		 		userpassword: {
		 			required : "비밀번호를 입력해주세요",
		 			minlength : "최소 {0}자 입력해주세요",
		 			passwordCk : "비밀번호는 영문, 숫자 조합으로 입력해주세요."
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
				 var userid = $("#userid").val();				 	
		 	  		 $.ajax({
		       			 url: '/signup/checkIdDuplication',
		                  type: 'post',
		                  data: {userid},
		                  success: function(retVal) {		 							
		 						if(retVal == "S"){
		 							var useremail = $("#useremail").val();
			 						$.ajax({
		 				       			 url: '/signup/checkEmailDuplication',
		 				                  type: 'post',
		 				                  data: {useremail},
		 					              success: function(retVal) {		 							
		 				 						if(retVal != ""){
		 				 							alert(retVal);
		 				 						} else{								
		 							
				 							  $.ajax({
			 						             url: '/signup/VerifyRecaptcha',
			 						             type: 'post',
			 						             data: {
			 						                 recaptcha: $("#g-recaptcha-response").val()
			 						        		     },
			 						             success: function(data) {
			 						                 switch (data) {
			 						                     case 0:
			 						                         signUpProc();
			 						                         break;			 
			 						                     case 1:
			 						                         alert("자동 가입 방지 봇을 확인 한 뒤 진행 해 주세요.");
			 						                         break;
			 						                     default:
			 						                         alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
			 						                         break;
			 						                 	}
			 						             	}
			 						         }); 
		 				 					}
		 				                  }
				 				         });
		 							} else{
										alert("중복된 아이디 입니다. 다른 아이디를 입력해주세요");
			 							}			
		                      	}
		           		   });				
		            }
		 });

 });


// 비밀번호 재확인
$(function(){
    $('#userpassword').keyup(function(){
      $('#passDubChk').html('');
    });

    $('#userpassword2').keyup(function(){

        if($('#userpassword').val() != $('#userpassword2').val()){
          $('#passDubChk').html('비밀번호 일치하지 않음<br><br>');
          $('#passDubChk').attr('color', '#da542e');
          $('#create_account').attr('disabled', 'disabled');
        } else{
          $('#passDubChk').html('비밀번호 일치함<br><br>');
          $('#passDubChk').attr('color', '#199894b3');         
          $('#create_account').removeAttr('disabled');
        }

    });
});  

function signUpProc(){
	if(confirm("가입하시겠습니까?")==true){
		document.frm.action = "/signup/signup.proc";
		document.frm.submit();
	}
} 

</script>









