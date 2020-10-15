<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%-- <tiles:getAsString name="title" /> --%></title>

<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="/plugins/daterangepicker/daterangepicker.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/adminlte.min.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">


<!-- jQuery -->
<script src="/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/plugins/moment/moment.min.js"></script>
<script src="/plugins/inputmask/min/jquery.inputmask.bundle.min.js"></script>
<script src="/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<script src="/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- Date Picker -->
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<!-- <script src="/dist/js/demo.js"></script> -->
<!-- <script src="/dist/js/common.js"></script> -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script type="text/javascript">

$(function() {
	 
	$.ajax({ 
		//type: "POST", 
		//contentType: "application/json", 
		url: "/cmmn/list", 
		//dataType: 'json', 
		success: function (data) { 
			console.log(data);
			
			if (data != null){

				for(i=0;i<data.user.length;i++){
// 						$("#bodyrightLayer").append("사용자");
// 						$("#bodyrightLayer").append(data.user[i].username+"=");
// 						$("#bodyrightLayer").append(data.user[i].score);
// 						$("#bodyrightLayer").append("<br/>");
						
						var userHtml = "";
						
						userHtml += '<div class="col-md-9 col-sm-6 col-12" style="padding:10 10 10 10;"><div class="user-block">';
						userHtml += '<img class="img-circle img-bordered-sm" src="/img/noprofile.png" alt="User Image">';
						userHtml += '<span class="username">';
						userHtml += '<a href="#">'+data.user[i].username+'</a>';
// 						userHtml += '<a href="#" class="float-right btn-tool"><i class="fas fa-times"></i></a>';
						userHtml += '</span>';
						userHtml += '<span class="description">'+data.user[i].score+'</span>';
						userHtml += '</div></div>';
						userHtml += '</div>';
						userHtml += '<div class="progress" style="height: 0.1rem;"><div class="progress-bar" style="width: 100%; background-color: #e9ecef;"></div></div>';
						 
						$("#userrightLayer").append(userHtml);
						
				}
				
				$("#bodyrightLayer").append("<br/>");
				
				for(y=0;y<data.partnerslist.length;y++){
					 var str = data.partnerslist[y].enterpriseabout;		
// 					$("#bodyrightLayer").append(data.partnerslist[y].enterprisename + " : " +str.link("/enterprises/activity/"+data.partnerslist[y].enterpriseno));
// 					$("#bodyrightLayer").append("-----------------------------");
// 					$("#bodyrightLayer").append("<br/>");

					var entHtml = "";
				

					entHtml += '<div class="col-md-9 col-sm-6 col-12" >';
					entHtml += '<div class="info-box ">'; /* bg-info */
					entHtml += '<span class="info-box-icon col-1"><i class="far fa-bookmark"></i></span>';
					entHtml += '<div class="info-box-content">';
					entHtml += '<span class="info-box-text ">'+data.partnerslist[y].enterprisename+'</span>';
					entHtml += '<div class="progress"><div class="progress-bar" style="width: 70%"></div></div>';
					entHtml += '<span class="progress-description">';
					entHtml += str.link("/enterprises/activity/"+data.partnerslist[y].enterpriseno);
					entHtml += '</span>';
					entHtml += '</div>';
					entHtml += '</div>';
					entHtml += '</div>';
					$("#bodyrightLayer").append(entHtml);
          		
				}

			//$("#bodyrightLayer").html(data.contents);
				}
			}, 
			error: function (e) { 
				alert("fail"); 
			} 
			});
});
  function numberWithCommas(x) {
    return x.toString().replace( /\B(?=(\d{3})+(?!\d))/g, "," );
  }
</script>

<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/index.css" />
<style>
.info-box .progress .progress-bar {
    background-color: #17a2b8;
}
.card-primary.card-outline {
    border-top: 3px solid #007bff;
}

</style>
</head>


<body class="hold-transition sidebar-mini control-sidebar-slide-open accent-indigo">
	<div class="wrapper">
		<tiles:insertAttribute name="header" />

		<aside class="main-sidebar sidebar-light elevation-4">
			<tiles:insertAttribute name="left" />
		</aside>
		<div class="content-wrapper">
			<div class="row">
				<div class="col-sm-8">
					<tiles:insertAttribute name="body" />
				</div>
				<div class="col-sm-4" id="bodyrightLayer">
				<br>
				<div class="card card-primary card-outline col-md-9" id="userrightLayer"></div>
				</div>
			</div>
		</div>
		<footer class="main-footer">
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>


</body>
</html>



  