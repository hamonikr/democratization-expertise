<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<body>

<form id="frm" name="frm" method="post">
<input type="hidden" id="user_ip" name="user_ip" value="127.0.0.1"/>
<input type="hidden" id="user_addr" name="user_addr" value="테스트 주소"/>


    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Legacy User Menu</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Legacy User Menu</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">${result.titl}</h3>
          <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
              <i class="fas fa-minus"></i></button>
            <button type="button" class="btn btn-tool" data-card-widget="remove" data-toggle="tooltip" title="Remove">
              <i class="fas fa-times"></i></button>
          </div>
        </div>
        <div class="card-body">
          ${result.user_id}
        </div>
        <div class="card-body">
          ${result.user_nm}
        </div>
        <div class="card-body">
          ${result.user_email}
        </div>
        <div class="card-body">
          ${result.user_hp}
        </div>
        <!-- /.card-body -->
        <div class="card-footer">
          ${result.ctnt }
        </div>
        <!-- /.card-footer-->
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->

  <!-- /.content-wrapper -->
    </form>
    <div class="right mT20">
                        <button type="button" class="btn_type2" onclick="location.href='sampleSave?seq=${result.seq}'">수정</button>
                        <button type="button" class="btn_type2" onclick="location.href='sampleList'"> 목록</button>
                    </div>
</body>
</html>