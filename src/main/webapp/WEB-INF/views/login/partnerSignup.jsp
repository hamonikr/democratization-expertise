<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*"%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>파트너사 회원가입</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>

</head>
<style>
.algin-center{
	margin : 20% 20px 20px 0px;
}

.algin-left{
	margin : 20% 10% 20px 25%;
}

</style>

<body class="hold-transition login-page">
 <div class="login-logo">
    <a href="/sample/list"><b>DE</b>HamoniKR</a>
  </div>

<div class="row">
<div class="col">
	<div class="algin-left">
	   <h3>
	    <img src="/img/HamoniKR_logo600.png" style="height:60px;"> 파트너사 회원가입
	 	</h3><br>
	   <h5>[DE] 커뮤니티에 가입하시면</h5><br>
	   <br>
	   <h6> 
	  	 질문을 통해 궁금했던 정보를 얻고<br><br> 투표와 답변을 통해 새로운 권한을 부여받고<br><br>
		 관심있는 태그와 위키문서를 저장할 수 있고<br><br>
		 그리고 명성과 배지를 얻을 수 있습니다<br><br>
		</h6>
		<br><br><br><br>
		일반 사용자이십니까? <a href="/login/signup">일반 사용자 회원가입</a>
	</div>
</div>

<div class="col">
<div class="login-box algin-center">
   <!-- /.login-logo -->
  <div class="card">
    <div class="card-body">
    
   <form id ="frm" method="post">   
     <!-- 아이디 입력 -->
     <div class="row">
     <div class="col">
     <div class="form-group">
    	 <p><strong>아이디 </strong>*
      <div class="input-group mb-3"> 
      	<input type="text" class="form-control" id= "userID" style="margin-left: 10px" placeholder="아이디를 입력해주세요">
       </div>
        </div>
       </div>
      </div>
      
      <!-- 이메일 -->  
     <div class="row">
     <div class="col">
     <div class="form-group">
    	 <p><strong>Email 주소 </strong>*
      <div class="input-group mb-3"> 
      	<input type="text" class="form-control" id="userEmail" style="margin-left: 10px" placeholder="이메일을 입력해주세요">
        </div>
        </div>
        </div>
      </div>    
 
      <!-- 이메일 -->  
     <div class="row">
     <div class="col">
     <div class="form-group">
    	 <p><strong>사업자 번호</strong>*
      <div class="input-group mb-3"> 
      	<input type="text" class="form-control" id="bizNo1" style="margin-left: 10px">
 	   	<input type="text" class="form-control" id="bizNo2" style="margin-left: 10px; width: 5px">
		<input type="text" class="form-control" id="bizNo3" style="margin-left: 10px; width: 5px">
      </div>
      </div>
    </div>
  </div>    
      
     <!-- 비밀번호 -->
     <div class="row">
      <div class="col">
      <div class="form-group">
      	<p><strong> 비밀번호</strong> *
       <div class="input-group mb-3">
        <input type="password" class="form-control" id="userPassword" style="margin-left: 10px" placeholder="비밀번호를 입력해주세요">
        </div>
       </div>
		</div>
		</div>
		
        <br>
       <div class="row">
        <div class="col">
			 <div class="g-recaptcha" data-sitekey="6LeS16wZAAAAADQYkYoSCaRt5wIb0YBSGGnnqVdH"></div>
       	   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
			    <!-- google reecaptcha 추가 -->
			    <script src='https://www.google.com/recaptcha/api.js'></script>
			    <script>
			        $(document).ready(function() {
			            $("#create_account").click(function() {
			                $.ajax({
			                    url: '/signup/VerifyRecaptcha',
			                    type: 'post',
			                    data: {
			                        recaptcha: $("#g-recaptcha-response").val()
			               		     },
			                    success: function(data) {
			                        switch (data) {
			                            case 0:
			                                alert("자동 가입 방지 봇 통과");
			                                break;
			 
			                            case 1:
			                                alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
			                                break;
			 
			                            default:
			                                alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
			                                break;
			                        }
			                    }
			                });
			            });
			        });
 
			    </script>
				<!--/recaptcha  -->

		</div>
		</div>
		  <div class="row">
       	 <div class="col">
       		<br><br>	
       		<!--   <input type="button" value="테스트 버튼" id="testBtn"> -->
       		  <input type="submit" value="계정 생성하기" class="btn btn-primary btn-block">
			</div>	
		</div>	
          <!-- /.col -->
      </form>
   		<!-- sign up part -->

    </div>
    <!-- /.login-card-body -->
  </div>
</div>
</div>
</div>

<!-- /.login-box -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 
function signUpProc(){
   		alert("계정을 생성하시겠습니까?")
		document.frm.action = "/signup/signupForPartner.proc";
		document.frm.submit();
} 
	
 $(document).ready(function() { 
		$('#frm').validate({
	 	 	   rules: {

	 	 		   //유저 아이디
					userId: {
						required : true
						},
					// 유저 이메일
	    		   userEmail:{
	    				required : true,
						email:true
	 	 	 		    },
						// 사업자번호1
		 	    		   bizNo1:{
		 	    				required : true,
						// 사업자번호2
		 	    		 }
	 	 	    		   bizNo2:{
	 	 	    				required : true,		 	    				
						// 사업자번호3
	 	 				}
	 	    		   		bizNo3:{
	 	    				required : true,			
	 	 	 		    },
						// 유저 비밀번호
	 	    		   userPassward:{
	 	    				required : true,
	 						
	 	 	 	 		    }
	 	 	   }, message:{
					// 핸드폰 번호
					userId:{
						required : "아이디를 입력해주세요."
							},							
	 	 		   //유저 이메일
					userEmail: {
						required : "이메일은 필수값 입니다.",
						email : "이메일 형식을 확인해주세요"
						},
					//유저 패스워드
					userPassward: {
						required : "비밀번호를 입력해주세요",
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
   		    }
		   	}); 

	 	$.validator.setDefaults({
 	 	    submitHandler: function () {
 	 	    	signUpProc();
 	 	    }
 	 	  });
	 
	});
</script>
</body>
</html>
