<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>home page</title>
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

  <!-- Compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css" media="screen,projection"/>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="semantic/dist/semantic.min.js"></script>
  <!-- Compiled and minified JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
</head>

<style>
#algin-center{
	margin : 30px 10% 5px 40%;
}
.nav-wrapper{
background-color:#FAFAFB;
}

#inputs{
/*     background-color: #FFFFFF; */
    border: 1px solid  #9e9e9e;
    border-radius: 5px;  
    background-color: -internal-light-dark-color(white, black);
 	 color:#151515;
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 10px;
    display: inline-block;
    cursor: text;
    font: 400 18px Arial;

}

a{
	color:#151515;
}
.brand-logo{
color:#151515;
}
</style>

<body>	

  <nav>
    <div class="nav-wrapper row">
      <div class="col-3">
      	<a href="/" class="brand-logo"><img src="/img/HamoniKR_lo	go600.png" style="height:40px;margin-left:10px;"> DE COMMUNITY</a>
			 	
	 	</div>	
	  <div class="col-3">	
	  	<input id ="inputs" >
	  </div>
	  <div class="col-2" >	
		 <button class="btn waves-effect waves-light" style="margin-left:10px;background-color:#2E64FE;" onClick="location.href='/login'">로그인 </button>		
		 <button class="btn waves-effect waves-light" style="margin-left:10px;background-color:#9F81F7;" onClick="location.href='/signup/signup'">회원가입 </button>		
    </div>
 
 	 <div align="right" class="col-3">	
    	<ul class="right hide-on-med-and-down">
        <li><a href="/"><i class="material-icons">account_circles</i></a></li>
        <li><a href="/"><i class="material-icons">announcement</i></a></li>
        <li><a href="/"><i class="material-icons">help</i></a></li>
        <li><a href="/users/logout"><i class="material-icons">power_settings_new</i></a></li>
      </ul> 
      </div>
          
      </div>
 </nav>
 <!--  <div class="col">
  <form action="https://www.google.com/search" method="GET">
        <div class="search-container align-center">
            <input type="checkbox" id="search-trigger">
            <label for="search-trigger">
                <div class="search-toggle"></div>
            </label>
            <label class="search-field">
                <input type="text" name="q" placeholder="">
                <div class="corners"></div>
            </label>
        </div>
    </form> 
    </div>
 -->
<div class="hold-transition login-page">
        <div>
        <h1>홈페이지입니다.</h1><br>
		 </div>
    </div>
</body>
<script type="text/javascript">

</script>
</html>
