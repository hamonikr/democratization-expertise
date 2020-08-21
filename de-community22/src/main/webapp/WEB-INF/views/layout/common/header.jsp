<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  
  
  <nav class="grey lighten-5" role="navigation">
    <div class="nav-wrapper container">
    	<a id="logo-container" href="/" class="brand-logo">
    		<img src="/img/HamoniKR_logo600.png" style="height:40px;margin-right:15px;margin-top:5px;">DE COMMUNITY
    	</a>
      <ul class="right hide-on-med-and-down">
 	  <li> <button class="btn waves-effect waves-light blue lighten-1" style="margin-left:10px;" onClick="location.href='/login'">로그인 </button></li>
      <li> <button class="btn waves-effect waves-light grey" style="margin-left:10px;" onClick="location.href='/signup/signup'">회원가입 </button></li>
      </ul>
    </div>
  </nav>
  
  <!--  Scripts-->
  <!-- <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script> -->
  <script src="/js/materialize.js"></script>
  <script src="/js/init.js"></script>

<!-- <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>
 -->
<!-- SEARCH FORM 
<form class="form-inline ml-3">
	<div class="input-group input-group-sm">
		<input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
		<div class="input-group-append">
			<button class="btn btn-navbar" type="submit">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</div>
</form>
-->


<!-- Right navbar links 
<ul class="navbar-nav ml-auto">
	<li class="nav-item dropdown"><a class="nav-link" data-toggle="dropdown" href="#"> <i class="far fa-comments"></i> <span class="badge badge-danger navbar-badge">3</span></a>
		<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
			<a href="#" class="dropdown-item">
				<div class="media">
					<img src="../../dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
					<div class="media-body">
						<h3 class="dropdown-item-title">
							Brad Diesel <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
						</h3>
						<p class="text-sm">Call me whenever you can...</p>
						<p class="text-sm text-muted">
							<i class="far fa-clock mr-1"></i> 4 Hours Ago
						</p>
					</div>
				</div>
			</a>
			<div class="dropdown-divider"></div>
			<a href="#" class="dropdown-item">
				<div class="media">
					<img src="../../dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
					<div class="media-body">
						<h3 class="dropdown-item-title">
							John Pierce <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
						</h3>
						<p class="text-sm">I got your message bro</p>
						<p class="text-sm text-muted">
							<i class="far fa-clock mr-1"></i> 4 Hours Ago
						</p>
					</div>
				</div>
			</a>
			<div class="dropdown-divider"></div>
			<a href="#" class="dropdown-item">
				<div class="media">
					<img src="../../dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
					<div class="media-body">
						<h3 class="dropdown-item-title">
							Nora Silvester <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
						</h3>
						<p class="text-sm">The subject goes here</p>
						<p class="text-sm text-muted">
							<i class="far fa-clock mr-1"></i> 4 Hours Ago
						</p>
					</div>
				</div>
			</a>
			<div class="dropdown-divider"></div>
			<a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
		</div></li>
</ul>
-->