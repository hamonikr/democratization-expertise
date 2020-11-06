<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<header class="topbar">
	<nav class="navbar top-navbar navbar-expand-md">

		<div class="navbar-header">
			<a class="nav-toggler d-block d-md-none" href="#"> <i class="mdi mdi-menu"></i></a>
			<!-- mobile menu -->
			<h1>
				<a class="navbar-brand" href="/"><img src="/img/logo.png" alt="" /></a>
			</h1>
			<!-- mobile user toggle -->
			<a class="topbartoggler d-block d-md-none" href="#" data-toggle="collapse" data-target="#user"> <i class="mdi mdi-dots-vertical"></i>
			</a>
		</div>

		<div class="top-search">
			<input type="text" name="" id="" placeholder="Search" />
			<button type="button">
				<i class="mdi mdi-magnify"></i>
			</button>
		</div>

		<div class="navbar-collapse collapse f-right" id="user">
			<div class="navbar-nav f-left mr-auto"></div>
			<ul class="navbar-nav  userinfo">
				<li class="profile">
					<span class="photo"><img src="/img/sample_profile.png" alt="" /></span> 
					<span class="alarm">알람</span> 
					<span class="level"><img src="/img/level_gold.png" alt="" /></span>
					<a href="#"> idmoca</a></li>

				<li><a href="#">Help</a></li>

				<li>
					<sec:authorize access="hasRole('ROLE_USER') || hasRole('ROLE_ADMIN')">
						<a href="javascript:;" style="margin-left:10px; width:100px;color: wheat;" onClick="location.href='/login/logout'">Sign out </a>
					</sec:authorize>
					<sec:authorize access="!(hasRole('ROLE_USER') || hasRole('ROLE_ADMIN'))">
						<a href="/login" style="margin-left:10px; width:100px;color: wheat;">Sign in</a>
						<a href="/signup/signup" style="margin-left:10px; width:100px;color: wheat;">Sign up</a>	
					</sec:authorize>
				</li>
			</ul>
		</div>

	</nav>
</header>
