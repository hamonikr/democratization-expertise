<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
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
  
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  
  <script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
 <meta name="google-signin-scope" content="profile email">
  <meta name="google-signin-client_id" content="1042506284094-s49av9n5sk34ell2u70lachpmihn07gu.apps.googleusercontent.com"></meta>

  
</head>
<style>
#algin-center{
	margin : 30px 10% 5px 40%;
}

</style>


<body class="hold-transition login-page">
<div class="login-box" id="algin-center">
  <div class="login-logo">
    <a href="/sample/list"><b>DE</b>HamoniKR</a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body" >
      <div class="login-box-msg"> <h3>로그인</h3></div>
      <form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="row">
		<div class="input-group mb-3">
          <div class="col-8">
				<strong>회원구분</strong>
			</div>
		</div>
	 </div>
		<div class="row">
	  		<div class="input-group mb-3">
		   		<p><input type="checkbox" id="user" value="0" style="margin-left: 10px" > 개인</p> 
		   		<p><input type="checkbox" id="partner" value="1" style="margin-left: 20px"> 파트너사</p>
      		</div>
      	</div>
     <div class="row">
     <div class="col"><p><strong>아이디 </strong>*</div>
     <div class="col-xs-3" >
     	<a href="forgot-id.html"> 아이디를 잊으셨습니까?</a>
     </div>
      <div class="input-group mb-3"> 
      	<input type="text" class="form-control" id="username" name="username" style="margin-left: 10px" placeholder="아이디를 입력해주세요">             	
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
            </div>
          </div>
        </div>
       <br>
        <div class="row">
        <div class="col"><p><strong> 비밀번호</strong> *</div>
         <div class="col-xs-3" >
     		<a href="forgot-pw.html">비밀번호를 잊으셨습니까?</a>
    	  </div>
         <div class="input-group mb-3">
          <input type="password" class="form-control" id="password" name="password" value="1234" style="margin-left: 10px" placeholder="비밀번호를 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
		</div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <!-- <input type="checkbox" id="remember">
              <label for="remember">
                기억하기
              </label> --> 
            </div>
          </div>
          </div>
          <!-- /.col -->
          <br>
         <div class="row">
            <button type="button" id ="submit_action" class="btn btn-primary btn-block">로그인</button>
          </div>
          <!-- /.col -->
      </form>
      
      
      <div class="social-auth-links text-center mb-3" style="margin:60px;">
      <br> <p>- SNS 계정으로 로그인 -</p>
        <div class="row" align="center" style="margin-left:40px;">
        
        <!-- 깃헙 -->
          <div class="col-2">
	         <a href="#" >  
				<img src="/img/logo.png" style="height:30px;margin-left:0px;">
		      </a>
	       </div>
	       
	       <!-- 구글 -->
		<div class="col-2" align="center">     	           
	      <!--  <img src="/img/google-plus.png" style="height:30px;margin-left:20px;"> -->	        	 
    		<div class="g-signin2" data-onsuccess="onSignIn" style="margin-left:15px;" data-width="30" data-height="32"></div> 
		     <a href="" onclick="signOut();">Sign out</a> 
	    </div>

	        <!-- 네이버 -->
	        <div class="col-2" id="naver_id_login" style="margin-left:30px;">	        	
	       		  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
	        </div>
	        
	        <!-- 카카오 -->
	        <div class="col-2">
		        <a href="/login/kakao">
		          <img src="/img/kakaolink_btn_medium_ov.png" style="margin-left:20px;height:32px;">
		        </a>
	        </div>
      	</div>
    </div>
      <!-- /.social-auth-links -->

		<!-- sign up part -->
		<div class="row" align="center">
	      <p class="col">계정이 없으십니까?
	        <a href="/login/signup" class="text-center">회원가입</a>
	  	  </p>
      </div>
      
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

 <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  var result = '${msg}';
 	 if(result != null || result !="") {
		if(result == "PW"){
		  console.log(">>"+result+"<<");	
		  alert("아이디와 비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
		}
	}	

 	// naver 로그인
   	var naver_id_login = new naver_id_login("PX4mWV3F_bqII3KVAVsl", "http://localhost:8080/login/naverCallback");
  	var state = naver_id_login.getUniqState();
 	
 	console.log(state);
  	
  	naver_id_login.setButton("green", 1,30);
  	naver_id_login.setDomain("http://localhost:8080/login/login");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();

 	 
   	// 일반 로그인 
  $(document).ready(function(){
 
	    $("#submit_action").on("click",submitAction);	

	    function submitAction(){
			var userId = $("#username").val();
			var userPassword = $("#password").val();

			if(userId == null || userId =="" || userId=="undefinded"){
				alert("아이디를 입력해주세요");
				$("#username").focus();	
				} else if(userPassword == null || userPassword =="" || userPassword=="undefinded"){
					alert("비밀번호를 입력해주세요");	
					$("#userPassword").focus();
					} else{
						document.frm.action = "/login/signin";
						document.frm.submit();
						alert("user id---->" + userId+"\n"+"userPassword---->" + userPassword);							
					}					
		}
  });

   	//구글 로그인
	   function onSignIn(googleUser) {
	       // Useful data for your client-side scripts:
	       var profile = googleUser.getBasicProfile();
	       console.log("ID: " + profile.getId());
	       console.log('Full Name: ' + profile.getName());
	       console.log("Image URL: " + profile.getImageUrl());
	       console.log("Email: " + profile.getEmail());
	
	       // The ID token you need to pass to your backend:
	       var id_token = googleUser.getAuthResponse().id_token;
	       console.log("ID Token: " + id_token);

			//var idChk = null;
	       $.ajax({
               url : "/login/checkDuplication/"+profile.getEmail(),
               headers : {
                     "Accept" : "application/json",
                     "Content-Type" : "application/json"
                 },
                 success : function(idChk){
						
						if(idChk==false){ //DB에 아이디가 없을 경우 => 회원가입
                           console.log("회원가입중...");
                           	  alert(idChk);
                           $.ajax({
                               url : "/signup/signup.proc",
                               method : "POST",
                               data : {
	                               userId : profile.getEmail(),
	                               userName : profile.getName(),
	                               userEmail: profile.getEmail(),
	                               userPassword : "@google"
                               },
                               success : function(retVal){
                                   if(retVal == "S"){
                                 		alert("회원가입이 정상적으로 되었습니다.");	
                                  		//$("frm").attr("method","POST").attr("action","/login/signin/"+profile.getEmail()).attr("target","_parent").submit();
		  										$.ajax({
		                            		   url : "/login/snsLogin",
		                                      method : "POST",    
		                                      data: {
		                                          username : profile.getEmail(),
		                                          password : "@google"
		                                           }                              		   
		  										});
                                       } else if(retVal == "F"){
                                  		alert("google 계정으로 회원가입 실패 ");
                                      	} else{
                                      		alert("google Login 실패. 관리자에게 문의주세요");
                                          	}
                               }
                          	 });
                       } else if(idChk==true){ //DB에 아이디가 존재할 경우 => 로그인
                    	   		alert(idChk);
								console.log("로그인중...");
                           //$("frm").attr("method","POST").attr("action","/login/signin/"+profile.getEmail()).attr("target","_parent").submit();
								$.ajax({
                         		   url : "/login/snsLogin",
                                   method : "POST",     
                                   data: {
                                      username : profile.getEmail(),
                                      password : "@google"
                                       }                       		   
									});
	                       		}
                 } 
             });	       
	      }
       
	  function signOut() {
	    var auth2 = gapi.auth2.getAuthInstance();
	    auth2.signOut().then(function () {
	     console.log('User signed out.');
	     });
	  } 
	
 </script> 
</body>
</html>
