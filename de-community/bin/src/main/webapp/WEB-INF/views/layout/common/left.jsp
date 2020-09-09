<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- Brand Logo -->
<!-- <a href="/main/index" class="brand-link">
	<img src="/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
	<span class="brand-text font-weight-light">DE</span>
	<span	class="brand-text font-weight-light">DE COMMUNITY</span>
</a>
 -->
<!-- Sidebar -->
<div class="sidebar">
	<!-- Sidebar user (optional) -->
	<!-- <div class="user-panel mt-3 pb-3 mb-3 d-flex">
		<div class="image">
			<img src="../../dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
		</div>
		<div class="info">
			<a href="#" class="d-block">Login User Info</a>
		</div>
	</div> -->

	<!-- Sidebar Menu -->

	<!-- stacked Q&A -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/questions/list" class="nav-link"> <i class="nav-icon far fa-stack-exchange"></i>
					<p>Q&As </p>
			</a></li>
		</ul>
	</nav>
	
	<!-- Tags -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/sample/list" class="nav-link"> <i class="nav-icon far fa-tag"></i>
					<p>Tags </p>
			</a></li>
		</ul>
	</nav>

	<!-- Users -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/users/list" class="nav-link"> <i class="nav-icon far fa-user"></i>
					<p>Users </p>
			</a></li>
		</ul>
	</nav>		

	<!-- Partners -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/enterprises/list" class="nav-link"> <i class="nav-icon far fa-users"></i>
					<p>Partners </p>
			</a></li>
		</ul>
	</nav>

	<!-- wiki -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
			<li class="nav-item"><a href="/sample/list" class="nav-link"> <i class="nav-icon far fa-wikipedia-w"></i>
					<p>Wiki </p>
			</a></li>
		</ul>
	</nav>

	<!-- 로그인 페이지 바로가기 (개발완료 후 사이드바에서 삭제예정) -->
<!-- 	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/login/login" class="nav-link"> <i class="nav-icon far fa-image"></i>
					<p>login </p>
			</a></li>
		</ul>
	</nav>
	
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/login/logout" class="nav-link"> <i class="nav-icon far fa-image"></i>
					<p>logout </p>
			</a></li>
		</ul>
	</nav>
 -->	
		<!-- wiki -->
	<nav class="mt-2">
		<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

			<li class="nav-item"><a href="/sample/list" class="nav-link"> <i class="nav-icon far fa-image"></i>
					<p>Sample </p>
			</a></li>
		</ul>
	</nav>
	
	<!-- /.sidebar-menu -->
</div>
<!-- /.sidebar -->