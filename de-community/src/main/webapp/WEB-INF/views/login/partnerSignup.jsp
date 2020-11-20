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
 
<div class="con-box">
<form id ="frm" name="frm" method="post">      
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
   	
    <div class="login bg2">
      <div class="join-info">
        <font class="blue bold">ASKOS에 가입하시면,</font> 
        질문을 통해 궁금했던 정보를 얻고 투표와 답변을 통해 새로운 권한을 부여받고 관심있는 태그와 위키문서를 저장할 수 있습니다.
      </div>
      <ul class="user-tab">
        <li><a href="/signup/signup">일반회원 가입</a></li>
        <li><a href="/signup/partnerSignup" class="current">파트너사 가입</a></li>
      </ul>
      <ul class="login-in">
        <li><label>회사명</label>
        	<div class="form-group"><input type="text" id="username" name="username" value="" placeholder="회사명을 입력해주세요" class="input-type1"></div>
<!--         	<input type="text" class="form-control englishOnly" id="username" name="username" value="testCompany" placeholder="회사명을 입력해주세요"> -->
        </li>
        <li>
        	<label>아이디</label>
		  <div class="form-group"><input type="text" class="input-type1 englishOnly" id="userid" name="userid" value="" placeholder="아이디를 입력해주세요"></div>
		</li>
        <li><label>E-mail 주소</label><div class="form-group"><input type="text" id="useremail" name="useremail" value=""  placeholder="이메일을 입력해주세요" class="input-type1"></div></li>
        <li><label>사업자번호</label>
        	<div>
	        	<span class="form-group"><input type="text" class=" input-type1 numberOnly" maxlength=3 id="bizNo1" value="" name="bizNo1" style=" width:15%"></span> -
		 	   	<span class="form-group"><input type="text" class=" input-type1 numberOnly" maxlength=2 id="bizNo2" value="" name="bizNo2" style="width:15%"></span> -     
			   	<span class="form-group"><input type="text" class=" input-type1 numberOnly" maxlength=5 id="bizNo3" value="" name="bizNo3" style="width:30%"></span>
			</div>
        </li>
        <li><label>비밀번호</label><div class="form-group"><input type="password" id="userpassword" name="userpassword" value="" placeholder="비밀번호를 입력해주세요" class="input-type1"></div></li>
        <li><label>비밀번호확인</label><input type="password" name="userpassword2" id="userpassword2" class="input-type1"><font id="passDubChk" size="1"></font></li>
        <li><div class="g-recaptcha" data-sitekey="6LeS16wZAAAAADQYkYoSCaRt5wIb0YBSGGnnqVdH"></div></li>
        <li>
        	<button type="submit" id="create_account"class="btn-blue">계정생성</button>
		</li>
      </ul>
<!--       <div class="mT20 mB10">- SNS 계정으로 회원가입하기 -</div> -->
<!--       <ul class="login-in3"> -->
<!--         <li><a href="#"><img src="/img/join_kakao.png" alt="kakao"></a></li> -->
<!--         <li><a href="#"><img src="/img/join_google.png" alt="google"></a></li> -->
<!--         <li><a href="#"><img src="/img/join_naver.png" alt="naver"></a></li> -->
<!--         <li><a href="#"><img src="/img/join_github.png" alt="github"></a></li> -->
<!--       </ul> -->
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

		// 숫자만
		$(".numberOnly").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});

		 $('#frm').validate({
			 rules: {
					username : { required: true },
				 	userid : { required: true, minlength: 3 },
                 useremail : { required: true, email: true },
                 userpassword : { required: true, minlength:6, passwordCk : true },
                 reuserpassword : { required: true, minlength:6, passwordCk : true },
                 bizNo1 : { required:true },
                 bizNo2 : { required:true },
                 bizNo3 : { required:true }
			  }, 
			  messages:{
				  username:{
			 			required : "회사명을 입력해주세요",
					  },
			 		userid:{
			 			required : "아이디를 입력해주세요",
			 			minlength : "최소 {0}자 입력해주세요"
			 			},							
			 	   useremail: {
			 			required : "이메일을 입력해주세요",
			 			email : "이메일 형식을 확인해주세요"
			 			},
			 		userpassword: {
			 			required : "비밀번호를 입력해주세요",
			 			minlength : "최소 {0}자 입력해주세요",
			 			passwordCk : "비밀번호는 영문, 숫자 조합으로 입력해주세요"
			 			},
			 		reuserpassword: {
			 			required : "비밀번호 확인을를 입력해주세요",
			 			minlength : "최소 {0}자 입력해주세요",
			 			passwordCk : "비밀번호는 영문, 숫자 조합으로 입력해주세요"
			 			},
			 		bizNo1: {
			 			required: ""
					 	},
			 		bizNo2: { 
			 			required: ""
					 	},
			 		bizNo3: { 
			 			required : "<div>사업자 번호를 입력해주세요</div>"	
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
				 						alert("사용가능한 아이디입니다.");
			 						 	var enterprisebizno = ($("#bizNo1").val() + $("#bizNo2").val() + $("#bizNo3").val());
			 							var chkbiz = true; 
			 							checkBizNo(enterprisebizno);
			 														
			 							if(chkbiz == true){
			 								alert("유효한 사업자 번호입니다.  "+chkbiz);
			 								$.ajax({
			 					             data : {'enterprisebizno':enterprisebizno},
			 					             url : "/signup/checkBizNoDuplication",
			 					             dataType : "json",
			 					             contentType: "application/json; charset=UTF-8",
			 					             success : function(chkBiz) {
			 					            	 if (chkBiz == 1) {                       
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
			 					                       
			 					                   } else {
			 					                       	alert("중복된 사업자번호입니다. 확인하시거나 관리자에게 문의주세요."+ chkBiz);
			 											}
			 									}
			 								});
			 							} else{
			 								alert("유효하지 않은 사업자번호입니다. 확인후 다시 입력해주세요");
			 							}
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

	// 사업자 번호 유효성 체크 
	function checkBizNo(bizno){
		if ((bizno = (bizno+'').match(/\d{1}/g)).length != 10) { 
			return false; 
		}
	
		var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];
	
		for (var i = 0 ; i < 9 ; i++) {
			 sum += (key[i] * Number(bizno[i]));
		 }
		return (10 - ((sum + Math.floor(key[8] * Number(bizno[8]) / 10)) % 10)) == Number(bizno[9]);
	}


	function signUpProc(){
		var enterprisebizno = ($("#bizNo1").val() + $("#bizNo2").val() + $("#bizNo3").val());
		var userid = $("#userid").val();
		var useremail = $("#useremail").val();
		var userpassword = $("#userpassword").val();

		
		if(confirm("가입하시겠습니까?")==true){
		   $.ajax({
	             url: '/signup/signupForPartner.proc',
	             data: {'userid': userid, 'useremail':useremail, 'enterprisebizno':enterprisebizno, 'userpassword':userpassword,  'username':$("#username").val()},
	             success: function(retVal) {
						if(retVal == "S"){
							location.href="/login";
							}
		             }
		   });			
			
		}
	} 


</script>
