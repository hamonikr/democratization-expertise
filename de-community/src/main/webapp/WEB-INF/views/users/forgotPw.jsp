<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>비밀번호 재설정</title>
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
<!-- 입력 박스 -->
<div class="col-3">
<div class="card">
 <div class="login-card-body" >
  <form id ="frm" name="frm" method="post">      
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>	
	<div class="row">
     <div class="col-4">
     </div>
     	<h6 style="margin-left:25px;">
			계정 암호를 잊어버렸거나 로그인하는 데 문제가 있으십니까?<br><br> 이메일 주소를 입력하면 임시비밀번호를 보내드리겠습니다.
		</h6>
     </div>
	<br>
	<!-- 이메일 -->  
     <div class="row">
     <div class="col-8">
     	<h6><strong>Email 주소</strong></h6>
     </div>
          	<div class="form-group col-12"> 	    
		      	<input type="email" class="form-control englishOnly" id="user_email" name="user_email" value="bono6315@gmail.com" style="margin-left: 10px" placeholder="이메일을 입력해주세요">             	
		   </div>
        </div>
       <br>
     
	
        <!-- button -->
		  <div class="row">
       	 <div class="col">
       		  <input type="submit" value="이메일 확인" class="btn btn-primary btn-block blue">
			</div>	
		  </div>	
        
      </form>
    </div>
  </div>
  </div>
 </div>

<!-- /.login-box -->
</body>


<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 

 $(document).ready(function() {

	// 영문, 숫자, 공백, 특수문자
		$(".englishOnly").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
		});	
	 
	 $('#frm').validate({
		 rules: {
		 	 
		 	  userEmail:{ required: true, email: true }
		    		  }, 
		  messages:{
		 								
			  user_email: {
		 			required : "이메일은 필수값 입니다.",
		 			email : "이메일 형식을 확인해주세요"
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
		 		sendRecoveryEmail();
		       }
		 });

 });
 
function sendRecoveryEmail(){
		document.frm.action = "/accountRecovery/sendRecoveryEmail";
		document.frm.submit();

} 

</script>