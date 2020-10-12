<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
<script src="/dist/js/demo.js"></script>
<script src="/dist/js/common.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script type="text/javascript">
function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>

<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/index.css" />
<style>
 .loginLayerBg {	 
 	background-image: url(/img/signbg.jpg); 
     background-size: cover; 
     height: 100%;
     width: 100%; 
 } 
</style>
</head>

<body class="hold-transition sidebar-mini control-sidebar-slide-open accent-indigo">
	<div class="wrapper " style="margin-left: -250px;">
		<tiles:insertAttribute name="header" />

		<div class="content-wrapper" style="margin-left: -250px;">
				<div class="col-12">
					<tiles:insertAttribute name="body" />
				</div>
		</div>
<!-- 		<footer class="main-footer"> -->
<%-- 			<tiles:insertAttribute name="footer" /> --%>
<!-- 		</footer> -->
	</div>

</body>


</html>

