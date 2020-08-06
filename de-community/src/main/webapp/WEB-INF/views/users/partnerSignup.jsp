<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>로그인</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  
  <!-- jquery-validation -->
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

	<!-- google reecaptcha 추가 --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
 
 <script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
 <meta name="google-signin-scope" content="profile email">
 <meta name="google-signin-client_id" content="1042506284094-s49av9n5sk34ell2u70lachpmihn07gu.apps.googleusercontent.com"></meta>
 
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link href="/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
 <link href="/css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  
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
<!-- nav bar -->
  <nav class="grey lighten-5" role="navigation">
    <div class="nav-wrapper container">
    	<a id="logo-container" href="/" class="brand-logo">
    		<img src="/img/HamoniKR_logo600.png" style="height:40px;margin-right:15px;margin-top:5px;">DE COMMUNITY
    	</a>   	
      <ul class="right hide-on-med-and-down">
	 	 <li> <button class="btn waves-effect waves-light blue lighten-1" style="margin-left:10px;" 
	 	 	onClick="location.href='/login'">로그인 </button>	
	 	 </li>
	     <li> <button class="btn waves-effect waves-light grey" style="margin-left:10px;" 
	     	onClick="location.href='/signup/signup'">회원가입 </button>	
	     </li>
      </ul>
    </div>
  </nav>

<!-- contents -->
<div class="hold-transition login-page">
  <!-- 회원가입 문구 -->
<div class="row">
  <div class="col-6">
	   <h3>
	    <img src="/img/HamoniKR_logo600.png" style="height:60px;">파트너사 회원가입
	 	</h3><br>
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
<div class="col-6" style="margin-left:;">
<div class="card">
 <div class="login-card-body" >
  <form id ="frm" name="frm" method="post">      
   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
     <!-- 아이디 입력 -->
   <div class="row">
     <div class="col-8">
     	<p><strong>아이디 </strong><strong style="color:red;">*</strong>
     </div>
          	<div class="form-group col-12"> 	    
		      	<input type="text" class="form-control" id="username" name="username" style="margin-left: 10px" placeholder="아이디를 입력해주세요">             	
		   </div>
        </div>
       <br>
	
	<!-- 이메일 -->  
     <div class="row">
     <div class="col-8">
     	<p><strong>Email 주소</strong><strong style="color:red;">*</strong>
     </div>
          	<div class="form-group col-12"> 	    
		      	<input type="text" class="form-control" id="userEmail" name="userEmail" style="margin-left: 10px" placeholder="아이디를 입력해주세요">             	
		   </div>
        </div>
       <br>
     
       <!-- 사업자 -->  
     <div class="row">
     <div class="col-12">
    	 <p><strong>사업자 번호</strong><strong style="color:red;">*</strong>     
    	 
      <div class="form-group">
      	<input type="text" class="form-control inputs" maxlength=3 id="bizNo1" style="margin-left: 10px; width:90px">
 	   	<input type="text" class="form-control inputs" maxlength=2 id="bizNo2" style="margin-left: 20px; width:60px">
		<input type="text" class="form-control inputs" maxlength=5 id="bizNo3" style="margin-left: 20px; width:110px">
      </div>
    </div>
  </div>    
         
     
     <!-- 비밀번호 -->
     <div class="row">
     <div class="col-8">
     	<p><strong>비밀번호</strong><strong style="color:red;">*</strong>
     </div>
          	<div class="form-group col-12"> 	    
		      	<input type="text" class="form-control" id="userPassword" name="userPassword" style="margin-left: 10px" placeholder="아이디를 입력해주세요">             	
		   </div>
        </div>
       <br>
             
       <!-- g-recaptcha -->
       <div class="row">
	      <div class="col-8">
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
  </div>
  </div>
 </div>
</div>

<!-- /.login-box -->
</body>


<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 
 var cnt=0;
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
                        	cnt=1;
                 		if(cnt==1){
                 			 $('#frm').validate({
                 	    	 	   rules: {
                 	   				userId: {
                 		   					required : true
                 		   					},
                 		       		   userEmail:{
                 		       				required : true,
                 		   						email:true
                 		    	 	 		    },
                 		   	    		   userPassward:{
                 		   	    				required : true,	 						
                 	   	 	 	 		    }
                 	    	 	   }, message:{
                 			   				userId:{
                 			   					required : "아이디를 입력해주세요."
                 			   						},							
                 			    	 		userEmail: {
                 			   					required : "이메일은 필수값 입니다.",
                 			   					email : "이메일 형식을 확인해주세요"
                 			   					},
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
                 	     		  	  	},
                 	     	 	     submitHandler: function(){
                 	    	 	    	signUpProc();
                 	     	   	 	  }
                 		   });                 			}			                                		
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


   //인풋박스 커서 자동이동  
   $(function() {
       $(".inputs").keyup (function () {
           var charLimit = $(this).attr("maxlength");
           if (this.value.length >= charLimit) {
               $(this).next().next('.inputs').focus();
               return false;
           }
       });
   });

	//validation check
  
     
 });
 
function signUpProc(){
		if(confirm("가입하시겠습니까?")==true){
		document.frm.action = "/signup/signup.proc";
		document.frm.submit();
	}
} 


</script>
