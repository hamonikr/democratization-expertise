<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<nav class="navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
<!--       <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li> -->
     
     <!-- logo -->
     <li class="nav-item d-none d-sm-inline-block"  style="margin-left:100px;">
       <a id="logo-container" href="/" class="brand-logo">
   		<img src="/img/HamoniKR_logo600.png" style="height:40px;margin-right:15px;margin-top:5px;">DE COMMUNITY
   		</a>
	 </li>	
    </ul>


    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
      <div class="input-group input-group" style="width:700px;margin-left:200px;">
        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
          <button class="btn btn-navbar" type="submit">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>
	
<!-- login/singup button -->
   <ul class="navbar-nav" style="margin-left:300px;'">
     <li> 
     <sec:authorize access="isAnonymous()">
   		  <button class="btn btn-block btn-primary" style="margin-left:10px; width:100px;background-color:#58ACFA;border-color:#FFFFFF;" onClick="location.href='/login'">로그인 </button>
     </sec:authorize>
     </li>
   	
   	  <li>    
   	   <sec:authorize access="isAnonymous()">
   	  		<button class="btn btn-block btn-secondary" style="margin-left:30px; width:100px;background-color:#A4A4A4;border-color:#FFFFFF;" onClick="location.href='/signup/signup'">회원가입 </button>
   	  	</sec:authorize>
   	 </li>
     <li> 
     	<sec:authorize access="hasRole('ROLE_USER')">
     		<button class="btn btn-block btn-primary" style="margin-left:10px; width:100px;background-color:#58ACFA;border-color:#FFFFFF;" onClick="location.href='/login/logout'">로그아웃 </button>
    </sec:authorize>
     </li>   
    </ul>
    
    <!-- Right navbar links -->
         	<sec:authorize access="hasRole('ROLE_USER')">
    
    <ul class="navbar-nav ml-auto">
      <!-- Messages Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" href="/users/profile">
          <i class="far fa-user-circle"></i>
          <span class="badge badge-danger navbar-badge"></span>
        </a>
      </li>
      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge">5</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <span class="dropdown-item dropdown-header">5개의 알림</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-comments mr-2"></i> 질문 [javascript에서...]에 대해<br> @Nora Silvester 님이 답변..
            <span class="float-right text-muted text-sm">3 분전</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-file mr-2"></i> 내가 작성한 [javascript]태그의<br> 위키문서를 @steve 님이 수정..
            <span class="float-right text-muted text-sm">12 시간전</span>
          </a>
          <div class="dropdown-divider"></div><hr>
          <a href="#" class="dropdown-item">
            <i class="fas fa-users mr-2"></i> 3 개의 회사 프로필 등록 <br>요청이 있습니다.
            <span class="float-right text-muted text-sm">2 일전</span>
          </a>
          <div class="dropdown-divider"></div><hr>
          <a href="#" class="dropdown-item dropdown-footer">모든 알림보기</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-question-circle"></i>
        </a>
      </li>
    </ul>
    </sec:authorize>
  </nav>

  
  <!--  Scripts-->
  <!-- <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script> -->
  <script src="/js/materialize.js"></script>
  <script src="/js/init.js"></script>
