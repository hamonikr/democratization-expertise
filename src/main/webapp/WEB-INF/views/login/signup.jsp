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
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<style>
#algin-center{
	margin : 30px 10% 5px 40%;
}

</style>


<body class="hold-transition login-page">
<div class="login-box" id="algin-center">
  <div class="login-logo">
    <a href="../../index2.html"><b>DE</b>HamoniKR</a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">회원가입</p>

      <form action="../../index3.html" method="post">
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

         <div class="input-group mb-3">
          <input type="password" class="form-control" style="margin-left: 10px" placeholder="비밀번호를 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
		</div>
          <br>
         <div class="row">
            <button type="submit" class="btn btn-primary btn-block">가입하기</button>
          </div>
          <!-- /.col -->
      </form>
   		<!-- sign up part -->

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
