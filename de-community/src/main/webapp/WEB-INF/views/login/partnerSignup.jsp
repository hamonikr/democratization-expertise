<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>파트너사 회원가입</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- jquery-validation -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 

  <!-- google reecaptcha 추가 --> 
  <script src='https://www.google.com/recaptcha/api.js'></script>
 
 <script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
 <meta name="google-signin-scope" content="profile email">
 <meta name="google-signin-client_id" content="1042506284094-s49av9n5sk34ell2u70lachpmihn07gu.apps.googleusercontent.com"></meta>
 
</head>
<style>
.card{
    background: #fff;
    border-top: 0;
    color: #666;
    padding: 20px
}

.algin-center{
	margin : 10% 10% 10% 10%;
}

strong{
	margin-left:5%;
	font-weight:20px;
	font-weight:bold;
}
</style>

<body>
<!-- contents -->
<div class="hold-transition login-page">
  <!-- 회원가입 문구 -->
<div class="row col-md-10" >
  <div class="col-6" >
	   <h3>
	    <img src="/img/HamoniKR_logo600.png" style="height:60px;"> 회원가입 for Partners
	 	</h3>
	 	<br>
	   <h5>[DE] 커뮤니티에 가입하시면</h5><br>
	   <br>
	   <h6> 
	  	 질문을 통해 궁금했던 정보를 얻고<br><br> 투표와 답변을 통해 새로운 권한을 부여받고<br><br>
		 관심있는 태그와 위키문서를 저장할 수 있고<br><br>
		 그리고 명성과 배지를 얻을 수 있습니다<br><br>
		</h6>
		<br><br><br><br>
		일반 사용자이십니까? <a href="/signup/signup">일반 사용자 회원가입</a>
   </div>
	
<!-- 입력 박스 -->
<div class="col-6" >
<!-- <div class="card" style="width:450px;"> -->
 <div class="login-card-body" >
  <form id ="frm" name="frm" method="post">      
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>     
     <!-- 회사이름 입력 -->
   		<div class="row">
     		<div class=" col-12"><span>회사명 * </span></div>
			<div class="form-group col-12"> 	    
		   		<input type="text" class="form-control englishOnly" id="username" name="username" value="testCompany" placeholder="회사명을 입력해주세요">             	
		   </div>
		</div>
     <!-- 아이디 입력 -->
   		<div class="row">
     		<div class=" col-12"><span>아이디 * </span></div>
			<div class="form-group col-12"> 	    
		   		<input type="text" class="form-control englishOnly" id="userid" name="userid" value="testCom" placeholder="아이디를 입력해주세요">             	
		   </div>
		</div>
      
	
	<!-- 이메일 -->  
     <div class="row">
     	<div class="col-12"><span>Email 주소 * </span></div>
		<div class="form-group col-12"> 	    
			<input type="email" class="form-control" id="useremail" name="useremail" value="test@test.com"  placeholder="이메일을 입력해주세요">             	
		</div>
		</div>
      
      
     
       	<!-- 사업자 번호-->  
     	<div class="row">
     		<div class="col-12"><span>사업자 번호 * </span></div>
	      <div class="form-group col-12">
	      		<input type="text" class=" numberOnly" maxlength=3 id="bizNo1" value="" name="bizNo1" style=" width:25%">
	 	   		<span style="margin-left:10px; width:20%;"> - </span> 
	 	   		<input type="text" class=" numberOnly" maxlength=2 id="bizNo2" value="" name="bizNo2" style="width:20%">       
	 	   		<span style="margin-left:10px; width:20%;"> - </span> 
		   		<input type="text" class=" numberOnly" maxlength=5 id="bizNo3" value="" name="bizNo3" style="width:30%">
	   		</div>
	 	</div>
  
     	<!-- 비밀번호 -->
     	<div class="row">
			<div class="col-12"><span>비밀번호 * </span></div>
			<div class="form-group col-12"> 	    
		   		<input type="password" class="form-control" id="userpassword" name="userpassword" value="test1234" placeholder="비밀번호를 입력해주세요">             	
		   </div>
		</div>
      
             
       <!-- g-recaptcha -->
       <div class="row">
	      <div class="col-12">
			   <div class="g-recaptcha" style="margin-left:25px;" data-sitekey="6LeS16wZAAAAADQYkYoSCaRt5wIb0YBSGGnnqVdH">
			   </div>
			</div>
		 </div>
		
		<br><br>	
        <!-- button -->
		  <div class="row">
       	 <div class="col">
       		  <input type="submit" id="create_account" value="계정 생성하기" class="btn btn-primary btn-block blue">
			</div>	
		  </div>	
        
      </form>
    </div>
<!--   </div> -->
  </div>
 </div>
</div>

<!-- /.login-box -->
</body>


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

		// 영문, 숫자, 공백, 특수문자
 		$(".englishOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
 		});

		//validation check	 
		 $('#frm').validate({
			 rules: {
					username : { required: true },
				 	userid : { required: true, minlength: 3 },
                 useremail : { required: true, email: true },
                 userpassword : { required: true, minlength:6, passwordCk : true },
                 bizNo1 : { required: true },
                 bizNo2 : { required: true },
                 bizNo3 : { required: true }
			  }, 
			  messages:{
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
			 		bizNo1: {
				 		required : "" 
					 	},
			 		bizNo2: { 
				 		required : "" 
					 	},
			 		bizNo3: { 
				 		required : "사업자 번호를 확인하세요" 
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
			 						if(retVal == "사용가능한 아이디입니다"){
			 						 	var enterprisebizno = ($("#bizNo1").val() + $("#bizNo2").val() + $("#bizNo3").val());
			 							var chkbiz = true; //checkBizNo(enterprisebizno);
			 														
			 							if(chkbiz == true){
			 								alert("유효한 사업자 번호이다 kkkk--> "+chkbiz);
			 								$.ajax({
			 					             data : {'enterprisebizno':enterprisebizno},
			 					             url : "/signup/checkBizNoDuplication",
			 					             dataType : "json",
			 					             contentType: "application/json; charset=UTF-8",
			 					             success : function(chkBiz) {
			 					            	 if (chkBiz == 1) {                       
			 					                       alert(chkBiz);
			 					                      $.ajax({
						 						             url: '/signup/VerifyRecaptcha',
						 						             type: 'post',
						 						             data: {
						 						                 recaptcha: $("#g-recaptcha-response").val()
						 						        		     },
						 						             success: function(data) {
						 						                 switch (data) {
						 						                     case 0:
						 						                         //alert("자동 가입 방지 봇 통과");
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
