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
    <div class="card-body login-card-body">
      <p class="login-box-msg">로그인</p>

      <form id="frm" action="/login/signin" method="post">
	<div class="row">
		<div class="input-group mb-3">
          <div class="col-8">
				<strong>회원구분</strong>
			</div>
		</div>
	 </div>
		<div class="row">
	  		<div class="input-group mb-3">
		   		<p><input type="checkbox" id="user" style="margin-left: 10px" > 개인</p> 
		   		<p><input type="checkbox" id="partner" style="margin-left: 20px"> 파트너사</p>
      		</div>
      	</div>
     <div class="row">
     <div class="col"><p><strong>아이디 </strong>*</div>
     <div class="col-xs-3" >
     	<a href="forgot-id.html"> 아이디를 잊으셨습니까?</a>
     </div>
      <div class="input-group mb-3"> 
      	<input type="text" class="form-control" style="margin-left: 10px" placeholder="아이디를 입력해주세요">             	
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
          <input type="password" class="form-control" style="margin-left: 10px" placeholder="비밀번호를 입력해주세요">
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
            <button type="submit" class="btn btn-primary btn-block">로그인</button>
          </div>
          <!-- /.col -->
      </form>
      
      
      <div class="social-auth-links text-center mb-3" style="margin:60px;">
      <br> <p>- SNS 계정으로 로그인 -</p>
        <div class="row" align="center">
          <div class="col-2">
	         <a href="#" >  
				<img src="/img/logo.png" style="height:30px;margin-left:0px;">
		      </a>
	       </div>
	       <div class="col-2">
	         <a href="/login/google" >
	          <img src="/img/google-plus.png" style="height:30px;margin-left:20px;">
	        </a>
	        </div>
	        <!-- <a href="/login/naver">
	          <img src="/img/naver_login.png" style="height:30px;margin-left:40px;">
	        </a> -->
	          <div class="col-2" id="naver_id_login" style="margin-left:20px;">
	          
				  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
				  <script type="text/javascript">
				  	var naver_id_login = new naver_id_login("PX4mWV3F_bqII3KVAVsl", "http://localhost:8080/login/naverCallback");
				  	var state = naver_id_login.getUniqState();
				  	naver_id_login.setButton("green", 1,30);
				  	naver_id_login.setDomain("http://localhost:8080");
				  	naver_id_login.setState(state);
				  	naver_id_login.setPopup();
				  	naver_id_login.init_naver_id_login();
				  </script>
	        </div>
	        <div class="col-2">
	        <a href="/login/kakao">
	          <img src="/img/kakao_login_small.png" style="height:30px;margin-left:60px;">
	        </a>
	        </div>
      	</div>
    </div>
      <!-- /.social-auth-links -->

		<!-- sign up part -->
		<div class="row">
	      <p class="col" style="margin-left:60px;">계정이 없으십니까?
	        <a href="/login/signup" class="text-center">회원가입</a>
	      </p>
      </div>
      
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>

</body>
</html>
