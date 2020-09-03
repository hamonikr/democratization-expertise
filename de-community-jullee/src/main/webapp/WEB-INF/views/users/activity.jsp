<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Users | Activity</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body >
<div class="wrapper">
<!--   <!-- Main Sidebar Container -->

  <!-- Content Wrapper. Contains page content -->
  <div class="">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1></h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/sample/list">Home</a></li>
              <li class="breadcrumb-item active">User Activity</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                  <img class="profile-user-img img-fluid img-circle"
                       src=""
                       alt="User profile picture">
                </div>

                <h3 class="profile-username text-center">${loginUser.username}</h3>

<%--                 <p class="text-muted text-center">${loginUser.userjob}</p>
 --%>
                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>명성</b> <a class="float-right">1,322</a>
                  </li>
                  <li class="list-group-item">
                    <b>배지</b> <a class="float-right"></a>
                  </li>
                  <li class="list-group-item">
                    <b>개인 블로그</b> <a class="float-right"></a>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title"></h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                  <strong><i class="fas fa-map-marker-alt mr-1"></i> 지역</strong>

                <p class="text-muted">서울, 대한민국</p>

                <hr>

                <strong><i class="fas fa-pencil-alt mr-1"></i> Tags</strong>

                <p class="text-muted">
                  <span class="tag tag-success">Coding,</span>
                  <span class="tag tag-info">Javascript,</span>
                  <span class="tag tag-primary">Java</span>
                </p>

                <hr>
					
					<strong><i class="fas fa-pencil-alt mr-1"></i> 소개글</strong>
		           <!--      <p class="text-muted">{loginUser.aboutme}</p> -->
             </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="nav-link active" href="/users/activity" data-toggle="tab">활동정보</a></li>
                  <li class="nav-item"><a class="nav-link" href="/users/profile" data-toggle="tab">프로필</a></li>
                </ul>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="activity">
                     <form class="form-horizontal">
            			</form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
</html>
