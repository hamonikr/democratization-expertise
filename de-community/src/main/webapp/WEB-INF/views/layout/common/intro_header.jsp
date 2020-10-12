<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="height: 55px;">

   
	<!-- Left navbar links -->
<!-- 	<ul class="navbar-nav"> -->
<!-- 		<li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a></li> -->
<!-- 		<li class="nav-item d-none d-sm-inline-block"> -->
<!-- 		</li> -->
<!-- 		<li class="nav-item d-none d-sm-inline-block"> -->
<!-- 		</li> -->
<!-- 	</ul> -->

    <div >
	    <font class="brand-link" style="height:56px; cursor: pointer;" onclick="javascript:location.href='/';">
	      <img src="/img/HamoniKR_logo600.png"
	           alt="AdminLTE Logo"
	           class="brand-image img-circle elevation-3"
	           style="opacity: .8">
	      <span class="brand-text font-weight-light">DE-COMMUNITY </span>
	    </font>
	</div>

	<!-- SEARCH FORM -->
	<form class="form-inline ml-3 col-7" name="sfrm" action="/search/list" method="post">
		<div class="input-group input-group-sm  col-9">
			<input class="form-control form-control-navbar" type="search" name="searchtxt" id="searchtxt" placeholder="Search" aria-label="Search">
			<!--  style="width: 600px;"-->
			<div class="input-group-append">
				<button class="btn btn-navbar" type="submit">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
	</form>

	<!-- Right navbar links -->

	<ul class="navbar-nav ">
		<li class="nav-item dropdown"><img src="/img/profile.png"></li>
		<li><img src="/img/alert.png" style="margin-left: 15px;"></li>
		<li><img src="/img/help.png" style="margin-left: 15px;"></li>
		<li><img src="/img/logout.png" style="margin-left: 15px;"><span style="color: white;"> 
			<sec:authorize access="hasRole('ROLE_USER')">
	     		<a href="javascript:;" style="margin-left:10px; width:100px;color: wheat;" 
	     		onClick="location.href='/login/logout'">로그아웃 </a>
	     	</sec:authorize>
	     	<sec:authorize access="!hasRole('ROLE_USER')">
	     	<a href="/login" style="margin-left:10px; width:100px;color: wheat;">Login</a>
	     	</sec:authorize>
			</span>
		</li>
	</ul>

	<!-- <ul class="navbar-nav ">
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge">3</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
      </li>
    </ul> -->
</nav>
<!-- /.navbar -->