<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!-- Brand Logo -->
    <div style="background-color:#8056D6">
    <font class="brand-link" style="height:56px; cursor: pointer;" onclick="javascript:location.href='/';">
      <img src="/img/HamoniKR_logo600.png"
           alt="AdminLTE Logo"
           class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">Hamoni-KR </span>
    </font>
</div>
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user (optional) -->
  

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
         
          <li class="nav-item">
            <a href="/" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Home</p></a>
          </li>
          <li class="nav-item">
            <a href="/questions/list" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Stacked Q&A</p></a>
          </li>
          <li class="nav-item">
            <a href="/tags/list" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Tags</p></a>
          </li>
          <li class="nav-item">
            <a href="/users/list" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Users</p></a>
          </li>
          <li class="nav-item">
            <a href="/enterprises/list" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Partners</p></a>
          </li>
          <li class="nav-item">
            <a href="/" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>Wiki</p></a>
          </li>
          <li class="nav-item">
            <a href="/" class="nav-link"><i class="nav-icon fas fa-th"></i> <p>NewsLetters</p></a>
          </li>
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
